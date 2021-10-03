library(tidyverse)

num <- c("1", "one", "一")


str_view(num, "[0-9]")
str_view(num, "[:digit:]")
str_view(num, "\\d")


str_view(num, "[a-z]")
str_view(num, "[:alpha:]") # 日本語も入る

str_view_all(num, "[a-z]")

str_view(num, "[a-z][a-z][a-z]")
str_view(num, "[a-z]..")
str_view(num, "[a-z]{3}")

str_view(num, "[0-9a-z]")
str_view_all(num, "[0-9a-z]")



test <- c("q1_test.x","q1_test.xx")

str_view_all(test, "^q1_.+\\.x$")
str_view_all(test, "^q1_.+xx$")

# 繰り返し


text <- c("test", "test_test", "test_test_test", "testtest", "test_testtest", "test_test_","teest_teest")

str_view(text, "(....)_\\1")
str_view(text, "(....)_\\1_\\1")
str_view(text, "(....)\\1")
str_view(text, "(.+)_\\1")
# str_view(text, "(....)_\\2")
# str_view(text, "(....)\\1_\\1")




map(vars, ~ count(mtcars, .data[[.x]])) %>% 
  set_names(vars) 

cross_tabyl = function(df, value_var, nest_vars = NULL){
  df %>%
    nest(data = -c({{nest_vars}})) %>%
    mutate(freq =
             map(data, ~ tabyl(.x, {{value_var}}))) %>%
    select(-data) %>%
    unnest(cols = c(freq)) %>%
    as_tibble()
}

# 関数
## ...について
## https://adv-r.hadley.nz/functions.html#fun-dot-dot-dot
## dot-dot-dot


# https://stackoverflow.com/questions/49594820/dplyr-mutate-at-and-case-when
library(psych)
bfi_tb <- as_tibble(bfi)

bfi %>%
  mutate_at(vars(A1:A2),
            funs(低値 = case_when(
              . <= 4 ~ 1,
              TRUE ~ 0
            ))
  ) %>%
  select(A1,A2,A1_低値,A2_低値)

df %>%
  mutate(across(everything(),
                ~case_when(. == 0~1,
                           . > 4 ~4,
                           TRUE ~ .)))
