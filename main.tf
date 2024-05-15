resource "yandex_dns_zone" "this" {
  for_each = { for entry in local.nested_zones : "${entry.zone}" => entry }
  name = each.value.name 
  zone = each.value.zone
  public = each.value.public
}

resource "yandex_dns_recordset" "this" {
  for_each = { for entry in local.nested_records : "${entry.fqdn}.${jsonencode(entry.records)}" => entry }
  name     = each.value.fqdn
  data     = try(each.value.records, null)
  ttl      = try(each.value.ttl, local.global.ttl)
  zone_id = try(yandex_dns_zone.this[each.value.zone]["id"], null)
  type     = each.value.type
}
