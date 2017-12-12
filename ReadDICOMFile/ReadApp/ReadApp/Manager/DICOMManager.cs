using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dicom.Imaging;
using System.Drawing.Imaging;
using Dicom;
using ReadApp.Model;
using System.Windows.Forms;
using System.IO;
using System.Drawing;
using ImageMagick;

namespace ReadApp.Manager
{
    class DICOMManager
    {
        public static DICOMManager shared = new DICOMManager();
        private DicomImage image;
        private string fileName; 
        private DICOMManager()
        {
            
        }

        public Int32 FramePerSecond = 12;

        public Double WindowWidth => image.WindowWidth;

        public Double WindowCenter => image.WindowCenter;

        public String FileName => fileName;

        public int FrameCount => image.NumberOfFrames;

        public Size FrameSize => new Size(image.Width, image.Height);

        public void Read(string filePath, string fileName)
        {
            this.image = new DicomImage(filePath);
            this.fileName = fileName;
        }

        public void ExportFrame(int frameNumber, ImageFormat format, string filePath)
        {
            if (frameNumber >= 0 && frameNumber <= image.NumberOfFrames)
            {
                using (Bitmap thumbBMP = image.RenderImage(frameNumber).AsBitmap())
                {
                    using (MemoryStream memory = new MemoryStream())
                    {
                        using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.ReadWrite))
                        {
                            thumbBMP.Save(memory, format);
                            byte[] bytes = memory.ToArray();
                            fs.Write(bytes, 0, bytes.Length);
                        }
                    }
                }
                
            }
        }

        public void ExportAllFrame(ImageFormat format, string folderPath)
        {
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }
            for (int i = 0; i < image.NumberOfFrames; i++)
            {
                var filePath = folderPath + (i + 1) + GetFilenameExtension(format);
                ExportFrame(i, format, filePath);
            }
        }

        public void ExportAllFrameToTempFolder()
        {
            var folderPath = Application.StartupPath + "\\data\\" + fileName + "\\";

            //if (Directory.Exists(folderPath))
            //{
            //    GC.Collect();
            //    GC.WaitForPendingFinalizers();
            //    Directory.Delete(folderPath, true);
            //}
            ExportAllFrame(ImageFormat.Tiff, folderPath);

        }

        public void ExportGifFile(string filePath)
        {
            

            using (MagickImageCollection collection = new MagickImageCollection())
            {
                using (Bitmap thumbBMP = image.RenderImage(0).AsBitmap())
                {
                    collection.Add(new MagickImage(thumbBMP));
                    collection[0].AnimationDelay = 1;
                }
                for (int i = 1; i < image.NumberOfFrames; i++)
                {
                    using (Bitmap thumbBMP = image.RenderImage(i).AsBitmap())
                    {
                        collection.Add(new MagickImage(thumbBMP));
                        collection[i].AnimationDelay = 1;
                    }
                }


                // Optionally reduce colors
                QuantizeSettings settings = new QuantizeSettings();
                settings.Colors = 256;
                collection.Quantize(settings);

                // Optionally optimize the images (images should have the same size).
                collection.Optimize();

                // Save gif
                collection.Write(filePath);
            }
        }

        //public static string GetFilenameExtension(ImageFormat format)
        //{
        //    return ImageCodecInfo.GetImageEncoders().FirstOrDefault(x => x.FormatID == format.Guid).FilenameExtension;
        //}

        public static string GetFilenameExtension( ImageFormat format)
        {
            try
            {
                return ImageCodecInfo.GetImageEncoders()
                        .First(x => x.FormatID == format.Guid)
                        .FilenameExtension
                        .Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries)
                        .First()
                        .Trim('*')
                        .ToLower();
            }
            catch (Exception)
            {
                return ".IDFK";
            }
        }
        public List<DICOMInfo> GetPatientTag()
        {
            var listInfo = new List<DICOMInfo>();
            var listPatientTag = new List<DicomTag>();
            listPatientTag.Add(DicomTag.PatientName);
            listPatientTag.Add(DicomTag.PatientID);
            listPatientTag.Add(DicomTag.PatientBirthDate);
            listPatientTag.Add(DicomTag.PatientSex);
            listPatientTag.Add(DicomTag.PatientAge);
            listPatientTag.Add(DicomTag.PatientWeight);
            listPatientTag.Add(DicomTag.PatientAddress);
            listPatientTag.Add(DicomTag.StudyDate);
            listPatientTag.Add(DicomTag.StudyTime);
            listPatientTag.Add(DicomTag.StudyID);
            listPatientTag.Add(DicomTag.Modality);
            listPatientTag.Add(DicomTag.StudyDescription);
            listPatientTag.Add(DicomTag.SeriesDate);
            listPatientTag.Add(DicomTag.SeriesTime);
            listPatientTag.Add(DicomTag.SeriesDescription);
            listPatientTag.Add(DicomTag.InstitutionName);
            listPatientTag.Add(DicomTag.InstitutionAddress);

            for (int i = 0; i < 17; i++)
            {
                var item = listPatientTag[i];
                try
                {
                    listInfo.Add(new DICOMInfo(item.ToString(), item.DictionaryEntry.Name, image.Dataset.Get<string>(item)));
                }
                catch (Exception)
                {
                    Console.WriteLine("Error when read Tag:" + item.DictionaryEntry.Name);
                }
                if (i == 6 || i == 11 || i == 14 || i == 16)
                {
                    listInfo.Add(new DICOMInfo());
                }
            }
            listInfo.Add(new DICOMInfo("WindowCenter", "Window Center",WindowCenter.ToString()));
            listInfo.Add(new DICOMInfo("WindowWidth", "Window Width", WindowWidth.ToString()));
            return listInfo;
        }

        public List<DICOMInfo> GetAllTag()
        {
            var listDICOMInfo = new List<DICOMInfo>();

            List<DicomItem> listDICOMItem = image.Dataset.ToList();
            foreach (var item in listDICOMItem)
            {
                try
                {
                    listDICOMInfo.Add(new DICOMInfo(item.Tag.ToString(), item.Tag.DictionaryEntry.Name, image.Dataset.Get<string>(item.Tag)));
                }
                catch (Exception)
                {
                    Console.WriteLine("Error when read Tag: " + item.Tag.DictionaryEntry.Name);
                }
            }
            return listDICOMInfo.OrderBy(item => item.TagDescription).ToList();
        }

        public int getNumberOfFrame()
        {
            return image.NumberOfFrames;
        }

        public string GetValueOfTag(DicomTag tag)
        {
            var value = "";
            try
            {
                value = image.Dataset.Get<string>(tag);
            }
            catch (Exception)
            {
                Console.WriteLine("Error when read Tag: " + tag.ToString());
            }
            return value;
        }
    }
}
