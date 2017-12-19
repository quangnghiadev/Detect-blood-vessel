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
        public static MatlabHelper shared = new MatlabHelper();
        private MLApp.MLApp matlab = new MLApp.MLApp();
        public void DetectVessel(string fileName)
        {
            matlab.Execute("cd " + Application.StartupPath + "\\matlab");
            object isDone = null;
            matlab.Feval("detect_vessel", 1, out isDone, fileName);

            object[] res = isDone as object[];
            bool result = (bool)res[0];
            Console.WriteLine("Result: " + result);
        }

        public double CalculateAccurary(string fileName)
        {
            matlab.Execute("cd " + Application.StartupPath + "\\matlab");
            object acccurary = null;
            matlab.Feval("calculate_accuracy", 1, out acccurary, fileName);

            object[] res = acccurary as object[];
            double result = (double)res[0];
            Console.WriteLine("Result: " + result);
            return result;
        }

    }
}
