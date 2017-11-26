using System.Windows.Forms;
using Dicom;
using Dicom.Imaging;
using System.Drawing.Imaging;

namespace ReadApp
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            ReadDICOMFile();
        }

        public void ReadDICOMFile()
        {
            //// Read DICOM file
            //var file = DicomFile.Open("3");
            ////Get Patient Info
            //var name = file.Dataset.Get<string>(DicomTag.PatientAddress);
            //get list image of dicom file
            var image = new DicomImage("86698558");
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
                image.RenderImage(i).AsBitmap().Save(dataPath + "86698558_frame" + (i+1) + ".tiff", ImageFormat.Tiff);
            }
        }

        public void CallMatlabFunc()
        {
            // Create the MATLAB instance 
            MLApp.MLApp matlab = new MLApp.MLApp();

            matlab.Execute("cd " + Application.StartupPath);

            object isReadOK = null;
            var imagePath = Application.StartupPath + "\\data\\1.jpg";
            matlab.Feval("processImage", 1, out isReadOK, imagePath);

            object[] res = isReadOK as object[];
            bool result = (bool)res[0];
            System.Console.WriteLine("Result: " + result);
        }
    }
}
