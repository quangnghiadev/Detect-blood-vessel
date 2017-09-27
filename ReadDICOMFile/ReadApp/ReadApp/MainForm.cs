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
            var file = DicomFile.Open("result.dcm");
            var name = file.Dataset.Get<string>(DicomTag.PatientAddress);
            var image = new DicomImage("goodSample");
            for (int i = 0; i < image.NumberOfFrames; i++)
            {
                image.RenderImage(i).AsBitmap().Save("/result/" + i + "result.jpg");
            }
            System.Console.WriteLine(name);
        }
    }
}
