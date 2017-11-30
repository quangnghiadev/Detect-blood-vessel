using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReadApp.Helper
{
    class MatlabHelper
    {
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
