locals {
  global = {
    ttl = 300
  }
  zones = [
    {
      name = "konoval.ru."
      public      = true
      records = [
        { name = "www", type = "A", records = ["10.0.0.1"], },
        { name = "srv1", type = "A", records = ["10.0.0.1"] },
        { name = "mysite", type = "A", records = ["10.0.0.1"] },
        { name = "foo", type = "A", records = ["10.0.0.1"] },
        { name = "bar", type = "A", records = ["10.0.0.1"] },
        { name = "graf", type = "A", records = ["10.0.0.1"] },
        { name = "graylog", type = "A", records = ["10.0.0.1"] },
        { name = "gitlab", type = "A", records = ["10.0.0.1"] },
        { name = "testproject", type = "A", records = ["10.0.0.1"] },

        { name = "oncall", type = "A", records = ["10.0.0.2"] },
        { name = "jenkins", type = "A", records = ["10.0.0.2"] },
        { name = "ursite", type = "A", records = ["10.0.0.2"] },
        { name = "dummy", type = "A", records = ["10.0.0.2"] },
        { name = "beaver", type = "A", records = ["10.0.0.2"] },
        { name = "kraken", type = "A", records = ["10.0.0.2"] },
        { name = "apex", type = "A", records = ["10.0.0.2"] },
        { name = "oops", type = "A", records = ["10.0.0.2"] },
        { name = "superproject", type = "A", records = ["10.0.0.2"] },

        { name = "srv3", type = "A", records = ["10.0.0.3"] },
        { name = "backend", type = "A", records = ["10.0.0.3"] },
        { name = "api", type = "A", records = ["10.0.0.3"] },
        { name = "api.dev", type = "A", records = ["10.0.0.3"] },
        { name = "api.staging", type = "A", records = ["10.0.0.3"] },
        { name = "mysql", type = "A", records = ["10.0.0.3"] },
        { name = "postgres", type = "A", records = ["10.0.0.3"] },
        { name = "prometheus", type = "A", records = ["10.0.0.3"] },
        { name = "frontend.test", type = "A", records = ["10.0.0.3"] },
      ]
    },
    {
      name = "sugarhoney.ru."
      public      = false
      records = [
        { name = "foobar", type = "A", records = ["10.0.0.4", "10.0.0.5"] },
        { name = "foobar2", type = "CNAME", records = ["srv3.konoval.ru"] },
      ]
    },
  ]
  
  nested_zones = distinct(flatten([
    for zone in local.zones : {
        name = replace(zone.name, ".", "")
        zone = zone.name 
        public = zone.public
    }
        

  ]
  ))

  nested_records = distinct(flatten([
    for zone in local.zones : [
      for sub in zone.records : {

        fqdn      = "${sub.name}.${zone.name}"
        zone      = zone.name
        subdomain = sub.name
        type      = sub.type
        records   = sub.records
    }]]
    )
  )
}
