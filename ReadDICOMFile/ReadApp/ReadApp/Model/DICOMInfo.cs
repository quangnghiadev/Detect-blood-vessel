using Dicom;
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
        private string tagDescription;

        public DICOMInfo()
        {
            tagName = "";
            tagValue = "";
            tagDescription = "";
        }

        public DICOMInfo(string tagName, string tagDes, string tagValue)
        {
            this.tagValue = tagValue;
            this.tagDescription = tagDes;
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

        public string TagDescription
        {
            get
            {
                return tagDescription;
            }
            set
            {
                tagDescription = value;
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
            return tagDescription + ": " + tagValue;
        }
    }
}
