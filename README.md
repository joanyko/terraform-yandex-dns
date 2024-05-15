# terraform-yandex-dns

## EXAMPLE: This is the contents of your variables.tf file
````
locals {
  zones = [
    {
      # Parent dns zone. Must end with a dot
      name = "konoval.ru." 

      # Is this a public dns zone
      public      = true

      # Comma-separated list of records.
      records = [
        { name = "srv1", type = "A", records = ["10.0.0.1"], },
        { name = "www", type = "CNAME", records = ["srv1.konoval.ru."] },
      ]
    },

      # Another one zone example
    {
      name = "sugarhoney.ru."
      public      = false
      records = [
        { name = "foobar", type = "A", records = ["10.0.0.4", "10.0.0.5"] },
        { name = "foobar2", type = "CNAME", records = ["srv3.konoval.ru"] },
      ]
    },
  ]
}
````