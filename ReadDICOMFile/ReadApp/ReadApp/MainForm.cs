using System.Windows.Forms;
using ReadApp.Helper;
using SegmentImage;
using SegmentImageNative;
using fuck;
using MLApp;
using MathWorks.MATLAB.NET.Arrays;
using System;
using System.Drawing;

namespace ReadApp
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            SegmentImage.MLBridge segment = new SegmentImage.MLBridge();
            fuck.Class1 cl = new fuck.Class1();
           










            MWArray boj = cl.fuck();
            

            if (boj.IsNumericArray)
            {
                Console.WriteLine("short %d" + boj.NumberofDimensions + "element" +boj.NumberOfElements);
                int[] dim = boj.Dimensions;
                byte[] fuck = new byte[512*512];
                MWNumericArray item2 = (MWNumericArray)boj;
                byte[,,] arr = (byte[,,])item2.ToArray(MWArrayComponent.Real);
                for (int i = 0; i < 512; i++)
                {
                    for (int j = 0; j < 512; j++)
                    {
                        fuck[i*j] = arr[0, i, j];
                    }
                }
                

                using (var ms = new System.IO.MemoryStream(fuck))
                {
                    using (var img = Image.FromStream(ms))
                    {
                        Console.WriteLine("hahahahaha");
                    }
                }
            }
            

        }

       

        

        private void MainForm_Load(object sender, System.EventArgs e)
        {

        }
    }
}
