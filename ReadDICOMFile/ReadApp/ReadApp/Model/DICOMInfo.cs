using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReadApp.Model
{
    class DICOMInfo
    {
        private string tagName;
        private string tagValue;

        public DICOMInfo()
        {
            tagName = "";
            tagValue = "";
        }

        public DICOMInfo(string tagName, string tagValue)
        {
            this.tagValue = tagValue;
            this.tagName = tagName;
        }

        public string TagName
        {
            get
            {
                return tagName;
            }
            set
            {
                tagName = value;
            }
        }

        public string TagValue
        {
            get
            {
                return tagValue;
            }
            set
            {
                tagValue = value;
            }
        }

        public string GetDescription()
        {
            return tagName + ": " + tagValue;
        }
    }
}
