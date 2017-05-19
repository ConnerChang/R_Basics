library(stringr)
tele_info <- c(
    "CC Wang (04)-123456",
    "Mrs. Hsu (or Mr. Liao), 0911 123 000",
    "Huang, 0912.123.222",
    "Dr. A, office: 02-555333 #111, cell: 0912-456789",
    "Mr. Chang, NONE"
)

str_extract(tele_info, pattern = "[0-9]")
str_extract(tele_info, pattern = "[0-9]+")
str_extract(tele_info, pattern = "[0-9-]+")
str_extract(tele_info, pattern = "[0-9-()]+")
str_extract(tele_info, pattern = "\\([0-9]{0,2}\\)-[0-9]+")
str_extract(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+")
str_extract(tele_info, pattern = "([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")
str_extract(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")
str_extract(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")
str_extract_all(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")
str_extract_all(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})", simplify = TRUE)

str_match(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")
str_match_all(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")

str_detect(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")

str_subset(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})")

str_replace(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})", replacement = "NONE")
str_replace_all(tele_info, pattern = "\\(?[0-9]{0,2}\\)?-[0-9]+[ ]?#?[0-9]+|([0-9]{4})[. -]?([0-9]{3})[. -]?([0-9]{3})", replacement = "NONE")