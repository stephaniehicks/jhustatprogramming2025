
#########################
# Example of a model-building ML pipeline
#########################

library(vip)

set.seed(123)
peng_split <- initial_split(penguins, prop = 0.8)
peng_train <- training(peng_split)
peng_test  <- testing(peng_split)

rf_spec <- rand_forest(mtry = 3) %>%
  set_engine("ranger", importance = "impurity") %>%
  set_mode("classification") # outcome is categorical
  
rf_fit <- rf_spec %>%
  fit(sex ~ bill_length_mm + flipper_length_mm + body_mass_g + species, 
      data = peng_train)

rf_preds <- predict(rf_fit, peng_test) |> 
  bind_cols(peng_test)

rf_preds |> 
  metrics(truth = sex, estimate = .pred_class)



