## code to prepare `download` dataset goes here

baixar_ano <- function(ano, path = "data-raw/csv") {
  fs::dir_create(path)
  link_base <- glue::glue(
    "https://carf.economia.gov.br/dados-abertos/dispe/carf_julgamentos_{ano}.",
    "zip/@@download/file/CARF_Julgamentos_{ano}.zip"
  )
  tmp <- fs::file_temp(ext = ".zip")
  httr::GET(link_base, httr::write_disk(tmp))
  zip::unzip(tmp, exdir = path)
}

purrr::walk(2012:2023, baixar_ano, .progress = TRUE)

usethis::use_data(download, overwrite = TRUE)
