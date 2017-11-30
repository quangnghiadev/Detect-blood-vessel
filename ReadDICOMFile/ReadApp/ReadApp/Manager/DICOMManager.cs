using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dicom.Imaging;
using System.Drawing.Imaging;
using Dicom;
using ReadApp.Model;

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
            if (frameNumber > 0 && frameNumber <= image.NumberOfFrames)
            {
                image.RenderImage(frameNumber).AsBitmap().Save(filePath, format);
            }
        }

        public void ExportAllFrame(ImageFormat format, string folderPath)
        {
            if (!System.IO.Directory.Exists(folderPath))
            {
                System.IO.Directory.CreateDirectory(folderPath);
            }
            for (int i = 1; i <= image.NumberOfFrames; i++)
            {
                var filePath = folderPath + fileName + "_" + i + format.ToString();
                ExportFrame(i, format, folderPath);
            }
        }

        public List<DICOMInfo> GetPatientInformation()
        {
            var listInfo = new List<DICOMInfo>();
            //Patient
            listInfo.Add(new DICOMInfo(DicomTag.PatientName.ToString(), image.Dataset.Get<string>(DicomTag.PatientName)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientID.ToString(), image.Dataset.Get<string>(DicomTag.PatientID)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientBirthDate.ToString(), image.Dataset.Get<string>(DicomTag.PatientBirthDate)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientSex.ToString(), image.Dataset.Get<string>(DicomTag.PatientSex)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientAge.ToString(), image.Dataset.Get<string>(DicomTag.PatientAge)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientWeight.ToString(), image.Dataset.Get<string>(DicomTag.PatientWeight)));
            listInfo.Add(new DICOMInfo(DicomTag.PatientAddress.ToString(), image.Dataset.Get<string>(DicomTag.PatientAddress)));

            //Study
            listInfo.Add(new DICOMInfo(DicomTag.StudyDate.ToString(), image.Dataset.Get<string>(DicomTag.StudyDate)));
            listInfo.Add(new DICOMInfo(DicomTag.StudyTime.ToString(), image.Dataset.Get<string>(DicomTag.StudyTime)));
            listInfo.Add(new DICOMInfo(DicomTag.StudyID.ToString(), image.Dataset.Get<string>(DicomTag.StudyID)));
            listInfo.Add(new DICOMInfo(DicomTag.ModalitiesInStudy.ToString(), image.Dataset.Get<string>(DicomTag.ModalitiesInStudy)));
            listInfo.Add(new DICOMInfo(DicomTag.StudyDescription.ToString(), image.Dataset.Get<string>(DicomTag.StudyDescription)));

            //Series
            listInfo.Add(new DICOMInfo(DicomTag.SeriesDate.ToString(), image.Dataset.Get<string>(DicomTag.SeriesDate)));
            listInfo.Add(new DICOMInfo(DicomTag.SeriesTime.ToString(), image.Dataset.Get<string>(DicomTag.SeriesTime)));
            listInfo.Add(new DICOMInfo(DicomTag.SeriesDescription.ToString(), image.Dataset.Get<string>(DicomTag.SeriesDescription)));

            return listInfo;
        }

        public List<DICOMInfo> GetAllTag()
        {
            var listInfo = new List<DICOMInfo>();



            return listInfo;
        }


    }
}
