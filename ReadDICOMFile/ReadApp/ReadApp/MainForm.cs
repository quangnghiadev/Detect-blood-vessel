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
        }

        

        private void MainForm_Load(object sender, System.EventArgs e)
        {

        }

        private void buttonOpen_Click(object sender, System.EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                System.Console.WriteLine(openFileDialog1.FileName);
            }
        }
    }
}
