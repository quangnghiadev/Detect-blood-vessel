using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dicom;
using Dicom.Imaging;
using System.Windows.Forms;
using System.Drawing.Imaging;

namespace ReadApp.Helper
{
    class ImageHelper
    {


        public static void ReadDICOMFile(String filePath)
        {
            //// Read DICOM file
            //var file = DicomFile.Open("3");
            ////Get Patient Info
            //var name = file.Dataset.Get<string>(DicomTag.PatientAddress);
            //get list image of dicom file.
            if (filePath == null || filePath.Length == 0)
            {
                filePath = "86698558";
            }
            var image = new DicomImage(filePath);
            //Check Path is exist or not
            var dataPath = Application.StartupPath + "\\data\\";
            if (!System.IO.Directory.Exists(dataPath))
            {
                System.IO.Directory.CreateDirectory(dataPath);
            }
            //Loop to save all image to data folder
            for (int i = 0; i < image.NumberOfFrames; i++)
            {
                //image.RenderImage(i).AsBitmap().Save(dataPath + "86697621_frame" + i + ".jpg");
                image.RenderImage(i).AsBitmap().Save(dataPath + "86698558_frame" + (i + 1) + ".tiff", ImageFormat.Tiff);
            }
        }
    }
}
