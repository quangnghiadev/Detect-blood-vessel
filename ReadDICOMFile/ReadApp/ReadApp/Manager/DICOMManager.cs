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

        public void Read(string filePath, string fileName)
        {
            this.image = new DicomImage(filePath);
            this.fileName = fileName;
        }

        public void ExportFrame(int frameNumber, ImageFormat format, string filePath)
        {
            if (frameNumber >= 0 && frameNumber <= image.NumberOfFrames)
            {
                image.RenderImage(frameNumber).AsBitmap().Save(filePath, format);
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
                var filePath = folderPath + fileName + "_" + i + "." + format.ToString();
                ExportFrame(i, format, filePath);
            }
        }

        public void ExportAllFrameToTempFolder()
        {
            var folderPath = Application.StartupPath + "\\data\\" + fileName + "\\";
            ExportAllFrame(ImageFormat.Tiff, folderPath);

        }

        public List<DICOMInfo> GetPatientInformation()
        {
            var listInfo = new List<DICOMInfo>();
            //Patient
            listInfo.Add(new DICOMInfo(DicomTag.PatientName.ToString(), "Patient Name", image.Dataset.Get<string>(DicomTag.PatientName)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientID.ToString(), "Patient ID", image.Dataset.Get<string>(DicomTag.PatientID)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientBirthDate.ToString(), "Patient Birth Date", image.Dataset.Get<string>(DicomTag.PatientBirthDate)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientSex.ToString(), "Patient Sex", image.Dataset.Get<string>(DicomTag.PatientSex)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientAge.ToString(), "Patient Age", image.Dataset.Get<string>(DicomTag.PatientAge)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientWeight.ToString(), "Patient Weight", image.Dataset.Get<string>(DicomTag.PatientWeight)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientAddress.ToString(), "Patient Address", image.Dataset.Get<string>(DicomTag.PatientAddress)));
            listInfo.Add(new DICOMInfo());
            //Study
            listInfo.Add(new DICOMInfo(DicomTag.StudyDate.ToString(), "Study Date", image.Dataset.Get<string>(DicomTag.StudyDate)));
            listInfo.Add(new DICOMInfo(DicomTag.StudyTime.ToString(), "Study Time", image.Dataset.Get<string>(DicomTag.StudyTime)));
            listInfo.Add(new DICOMInfo(DicomTag.StudyID.ToString(), "Study ID", image.Dataset.Get<string>(DicomTag.StudyID)));
            listInfo.Add(new DICOMInfo(DicomTag.Modality.ToString(), "Study Modality", image.Dataset.Get<string>(DicomTag.Modality)));
            listInfo.Add(new DICOMInfo(DicomTag.StudyDescription.ToString(), "Study Description", image.Dataset.Get<string>(DicomTag.StudyDescription)));
            listInfo.Add(new DICOMInfo());
            //Series
            listInfo.Add(new DICOMInfo(DicomTag.SeriesDate.ToString(), "Series Date", image.Dataset.Get<string>(DicomTag.SeriesDate)));
            listInfo.Add(new DICOMInfo(DicomTag.SeriesTime.ToString(), "Series Time", image.Dataset.Get<string>(DicomTag.SeriesTime)));
            listInfo.Add(new DICOMInfo(DicomTag.SeriesDescription.ToString(), "Series Description", image.Dataset.Get<string>(DicomTag.SeriesDescription)));

            return listInfo;
        }

        public List<DICOMInfo> GetAllTag()
        {
            var listInfo = new List<DICOMInfo>();



            return listInfo;
        }


    }
}
