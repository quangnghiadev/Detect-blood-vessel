using System.Windows.Forms;
using Dicom;
using Dicom.Imaging;

namespace ReadApp
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        public void ReadDICOMFile()
        {
           // Read DICOM file
            var file = DicomFile.Open("result.dcm");
            //Get Patient Info
            var name = file.Dataset.Get<string>(DicomTag.PatientAddress);
            //get list image of dicom file
            var image = new DicomImage("goodSample");
            //Check Path is exist or not
            var dataPath = Application.StartupPath + "\\data\\";
            if (!System.IO.Directory.Exists(dataPath))
            {
                System.IO.Directory.CreateDirectory(dataPath);
            }
            //Loop to save all image to data folder
            for (int i = 0; i < image.NumberOfFrames; i++)
            {
                image.RenderImage(i).AsBitmap().Save(dataPath + i + ".jpg");
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
