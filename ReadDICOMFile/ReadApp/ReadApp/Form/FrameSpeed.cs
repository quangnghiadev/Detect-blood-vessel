using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ReadApp.Manager;

namespace ReadApp
{
    public partial class FrameSpeed : Form
    {
        public FrameSpeed()
        {
            InitializeComponent();
            comboBox1.Text = DICOMManager.shared.FramePerSecond.ToString();
        }
        
        private void button1_Click(object sender, EventArgs e)
        {
            DICOMManager.shared.FramePerSecond = Convert.ToInt32(comboBox1.Text);
            this.Close();
        }

        private void FrameSpeed_FormClosing(object sender, FormClosingEventArgs e)
        {
            var frm = Application.OpenForms.Cast<Form>().Where(x => x.Name == "MainForm").FirstOrDefault() as MainForm;
            if (null != frm)
            {
                frm.SetFramePerSecondLabel(DICOMManager.shared.FramePerSecond.ToString());
                frm = null;
            }
        }
    }
}
