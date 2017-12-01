using System.Windows.Forms;
using Dicom;
using Dicom.Imaging;
using System.Drawing.Imaging;
using ReadApp.Manager;
using System.Data;

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
                DICOMManager.shared.Read(openFileDialog1.FileName, openFileDialog1.SafeFileName);
                FillPatientInformationGridView();
            }
        }

        private void FillPatientInformationGridView()
        {
            DataTable table = new DataTable();
            table.Columns.Add("TagName", System.Type.GetType("System.String"));
            table.Columns.Add("TagDes", System.Type.GetType("System.String"));
            table.Columns.Add("TagValue", System.Type.GetType("System.String"));
            var list = DICOMManager.shared.GetPatientInformation();
            foreach (var item in list)
            {
                table.Rows.Add(item.TagName, item.TagDescription, item.TagValue);
            }
            dataGridViewPatientInfo.DataSource = table;
            dataGridViewPatientInfo.Columns[0].Visible = false;
        }
    }
}
