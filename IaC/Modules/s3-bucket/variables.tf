variable "module-bucket-name" {
  type = string
}

variable "module-website-path" {
  type = string
}

variable "mime-types" {
  type = map(string)

  default = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".min.css" = "text/css"
    ".css.map" = "application/json"
    ".min.css.map" = "application/json"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".pdf"  = "application/pdf"
    ".json" = "application/json"
    ".js"   = "application/javascript"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".mp4"  = "video/mp4"
    ".eot" = "application/vnd.ms-fontobject"
    ".ttf" = "font/ttf"
    ".woff" = "font/woff"
    ".woff2" = "font/woff2"
  }
}