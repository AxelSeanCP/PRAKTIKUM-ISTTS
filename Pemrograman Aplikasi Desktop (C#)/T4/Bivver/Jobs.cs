﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bivver
{
    public class Jobs
    {
        public Jobs(string applicant, string category, string description, int harga)
        {
            this.applicant = applicant;
            this.category = category;
            this.description = description;
            this.harga = harga;
            this.worker = "-";
            this.status = "Menunggu";
        }

        public string applicant { get; set; }
        public string category { get; set; }
        public string description { get; set; }
        public string worker { get; set; }
        public int harga { get; set; }
        public string status { get; set; }
    }

}
