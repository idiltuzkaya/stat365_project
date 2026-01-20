# 1. Prepare numeric Salary Rank (1 to 5)
clean_data$salary_num <- as.numeric(factor(clean_data$salary_clean, 
                                           levels = c("< 30,000", "30,000–49,999", "50,000–69,999", 
                                                      "70,000–99,999", "100,000+")))

# 2. Prepare numeric GPA Rank (1 to 5)
clean_data$gpa_num <- as.numeric(factor(clean_data$`6- Please indicate your current cumulative GPA (on a 4.00 scale).`,
                                        levels = c("0–2.0", "2.01–2.5", "2.51–3.0", "3.01–3.5", "3.51–4.0")))

# 3. Ensure Gender and Faculty are factors
clean_data$gender_f <- as.factor(clean_data$`5- Which of the following best describes your gender identity?`)
clean_data$faculty_f <- as.factor(clean_data$faculty_merged)

# 4. Run the Multiple Linear Regression
model <- lm(salary_num ~ gpa_num + gender_f + faculty_f, data = clean_data)

# 5. Check results
summary(model)



# Visual check (The 4 standard plots)
par(mfrow = c(2, 2))
plot(model)







library(dplyr)
library(tidyr)
library(ggplot2)
library(forcats)

# 0. Pick the Likert variables directly from the dataset
likert_vars <- clean_data %>%
  select(
    `19- Financial security is the single most important aspect when choosing my first job (1 = Strongly disagree → 5 = Strongly agree)`:
      `28- I believe my long-term career success depends more on luck than on hard work. (1 = Strongly disagree → 5 = Strongly agree)`
  ) %>%
  names()

# 1. Reshape Likert data
likert_long <- clean_data %>%
  select(all_of(likert_vars)) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Question",
    values_to = "Response"
  ) %>%
  filter(!is.na(Response))

# 2. Cleaner, shorter labels
likert_long$Question <- fct_recode(
  likert_long$Question,
  "Financial Security Priority" =
    "19- Financial security is the single most important aspect when choosing my first job (1 = Strongly disagree → 5 = Strongly agree)",
  "Leave Job < 3 Years" =
    "20- I expect to stay at my first job for less than three years.",
  "Diploma Importance" =
    "21- I believe my diploma alone will be enough for me to find a good job. (1 = Strongly disagree → 5 = Strongly agree)",
  "Need Second Job" =
    "22- I think I might need a second job to maintain a decent standard of living. (1 = Strongly disagree → 5 = Strongly agree)",
  "Flexibility Priority" =
    "23- Having flexibility (remote work, flexible hours) is a priority for me in a job. (1 = Strongly disagree → 5 = Strongly agree)",
  "Work Abroad" =
    "24- I am open to considering work opportunities abroad. (1 = Strongly disagree → 5 = Strongly agree)",
  "Work-Life Balance > Prestige" =
    "25- I think work–life balance is more important than career prestige. (1 = Strongly disagree → 5 = Strongly agree)",
  "Values > Salary" =
    "26- I would accept a lower salary for a job that aligns with my values. (1 = Strongly disagree → 5 = Strongly agree)",
  "Work > 40 Hours" =
    "27- I believe I need to work more than 40 hours a week to earn a high salary. (1 = Strongly disagree → 5 = Strongly agree)",
  "Success is Luck" =
    "28- I believe my long-term career success depends more on luck than on hard work. (1 = Strongly disagree → 5 = Strongly agree)"
)

# 3. Your original color palette
likert_palette <- c(
  "Strongly disagree" = "#4C72B0",
  "Disagree"          = "#55A868",
  "Neutral"           = "#999999",
  "Agree"             = "#C44E52",
  "Strongly agree"    = "#8172B3"
)

# 4. Stacked likert (percent)
p_likert <- ggplot(likert_long, aes(x = Question, fill = Response)) +
  geom_bar(position = "fill", width = 0.75) +
  coord_flip() +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = likert_palette) +
  labs(
    title = "Distribution of Work Values and Career Attitudes",
    x = NULL, y = "Percentage of Responses", fill = "Response"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", panel.grid.major.y = element_blank())

p_likert
#ggsave("figures/rq3_likert_distribution.svg", p_likert, width = 9, height = 6)

# 5. Faceted bar counts
p12 <- ggplot(likert_long, aes(x = Response, fill = Response)) +
  geom_bar(width = 0.7) +
  facet_wrap(~ Question, scales = "free_y", ncol = 3) +
  scale_fill_manual(values = likert_palette) +
  labs(
    title = "Distribution of Responses to Career Attitude Statements",
    x = NULL, y = "Number of Students"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 30, hjust = 1),
    strip.text = element_text(face = "bold")
  )

p12
#ggsave("figures/rq3_work_values_likert.svg", p12, width = 7, height = 4)