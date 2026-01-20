library(readxl)
df <-  read_xlsx("~/Desktop/STAT365 – METU Student Career Expectations and Work Preferences Survey (Responses).xlsx") 

is_turkish <- df[, 2] == "Türkçe -Turkish"
is_english <- df[, 2] == "İngilizce-English"

# Turkish: Use "is_turkish" rows, and columns 1 through 43
turkish_data <- df[is_turkish, 1:43]

# English: Use "is_english" rows, and columns 1, 2, and 44 through 84
english_data <- df[is_english, c(1, 2, 44:84)]

# Save separated
write.csv(turkish_data, "turkish_separated.csv", row.names = FALSE)
write.csv(english_data, "english_separated.csv", row.names = FALSE)

colnames(turkish_data)
colnames(english_data)

# Apply English headers to Turkish
colnames(turkish_data) <- colnames(english_data)

# Translation dictionary
trans_dict <- c(
  "Kimya" = "Chemistry",
  "Bilgisayar ve Öğretim Teknolojileri Eğitimi" = "Computer Education and Instructional Technology",
  "Elektrik ve Elektronik Mühendisliği" = "Electrical and Electronics Engineering",
  "Endüstri Mühendisliği" = "Industrial Engineering",
  "Endüstri Ürünleri Tasarımı" = "Industrial Design",
  "Tarih" = "History",
  "İstatistik" = "Statistics",
  "Bilgisayar Mühendisliği" = "Computer Engineering",
  "Matematik" = "Mathematics",
  "Havacılık ve Uzay Mühendisliği" = "Aerospace Engineering",
  "İnşaat Mühendisliği" = "Civil Engineering",
  "Fizik" = "Physics",
  "Gıda Mühendisliği" = "Food Engineering",
  "Şehir ve Bölge Planlama" = "City and Regional Planning",
  "İktisat" = "Economics",
  "Moleküler Biyoloji ve Genetik" = "Molecular Biology and Genetics",
  "Siyaset Bilimi ve Kamu Yönetimi" = "Political Science and Public Administration",
  "Makina Mühendisliği" = "Mechanical Engineering",
  "Petrol ve Doğal Gaz Mühendisliği" = "Petroleum and Natural Gas Engineering",
  "Uluslararası İlişkiler" = "International Relations",
  "Biyoloji" = "Biology",
  "Matematik Eğitimi" = "Mathematics Education",
  "İngilizce Öğretmenliği" = "English Language Teaching",
  "Psikoloji" = "Psychology",
  "Jeoloji Mühendisliği" = "Geological Engineering",
  "Kimya Eğitimi" = "Chemistry Education",
  "Çevre Mühendisliği" = "Environmental Engineering",
  "Yabancı Diller Eğitimi" = "Foreign Language Education",
  "Kimya Mühendisliği" = "Chemical Engineering",
  "Metalurji ve Malzeme Mühendisliği" = "Metallurgical and Materials Engineering",
  "Mimarlık" = "Architecture",
  "Maden Mühendisliği" = "Mining Engineering",
  "Fizik Eğitimi" = "Physics Education",
  "İşletme" = "Business Administration",
  "Felsefe" = "Philosophy",
  
  "Hayır" = "No",
  "Evet" = "Yes",
  "Evet, yandal yapıyorum" = "Yes, minor",
  "Evet, çift anadal yapıyorum" = "Yes, double major",
  "Evet, yarı zamanlı" = "Yes, part-time",
  "Evet, stajyer olarak" = "Yes, as an intern",
  "Muhtemelen evet" = "Probably yes",
  "Muhtemelen hayır" = "Probably no",
  "Emin değilim" = "Not sure",
  "Belirtmek istemiyorum" = "Prefer not to say",
  
  "4. sınıf" = "4th year",
  "3. sınıf" = "3rd year",
  "2. sınıf" = "2nd year",
  "1. sınıf" = "1st year",
  "Mezun" = "Graduated",
  "Hazırlık" = "Preparatory",
  "Yüksek Lisans" = "Master's",
  "Kadın" = "Female",
  "Erkek" = "Male",
  "Söylemeyi tercih etmiyorum" = "Prefer not to say",
  "24 ve üzeri" = "24 and over",
  "18 yaş altı" = "Under 18",
  
  "Nadiren" = "Rarely",
  "Ara sıra" = "Sometimes",
  "Hiçbir zaman" = "Never",
  "Sık sık" = "Often",
  "Çok sık" = "Very often",
  "Ara sıra aktifim" = "Somewhat active",
  "Hiç aktif değilim" = "Not active at all",
  "Nadiren aktifim" = "Rarely active",
  "Sık aktifim" = "Active",
  "Çok aktifim" = "Very active",
  
  "Tam zamanlı işe başlamak" = "Start a full-time job",
  "Yüksek lisans veya doktora yapmak" = "Pursue a Master's or PhD",
  "Ara yıl (gap year) vermek" = "Take a gap year",
  "Kendi işimi kurmak" = "Start my own business",
  "Planım yok" = "No plan",
  "Alanımı derinlemesine öğrenmek" = "To gain in-depth knowledge of my field",
  "Yurtdışında deneyim kazanmak" = "To gain experience abroad",
  "İş piyasasında rekabet avantajı elde etmek" = "To gain a competitive advantage in the job market",
  "Akademik kariyer hedefi (araştırma / öğretim üyesi olmak)" = "Academic career goal",
  "Staj / iş deneyimi" = "Internship / work experience",
  "Seyahat / kültürel değişim" = "Travel / cultural exchange",
  
  "Henüz emin değilim" = "Not sure yet",
  "Kişisel birikimlerimle" = "Personal savings",
  "Aile veya arkadaş desteğiyle" = "Family or friends support",
  "Teknoloji / Yazılım" = "Technology / Software",
  "Üretim / Mühendislik" = "Manufacturing / Engineering",
  "Gıda / Turizm / Perakende" = "Food / Tourism / Retail",
  "Eğitim / Öğretim" = "Education / Training",
  "Yaratıcı Endüstriler (Medya, Tasarım, Pazarlama)" = "Creative Industries (Media, Design, Marketing)",
  "Burs / finansal destek olanakları" = "Scholarship / financial support",
  "Konum (ülke / şehir)" = "Location (country / city)",
  "Üniversitenin itibarı" = "University reputation",
  "İş olanakları" = "Job opportunities",
  "Mezuniyetin hemen ardından" = "Immediately after graduation",
  "İş deneyimi kazandıktan sonra" = "After gaining work experience",
  
  "Türkiye’de – yerel firma" = "In Turkey – local company",
  "Türkiye’de – uluslararası firma" = "In Turkey – international company",
  "Yurtdışında" = "Abroad",
  "Kendi işimde" = "Own business",
  "Bilmiyorum" = "I don't know",
  "Hibrit" = "Hybrid",
  "Ofiste" = "In-office",
  "Tamamen uzaktan" = "Fully remote",
  
  "1 (En önemli)" = "1 (Most important)",
  "5 (En az önemli)" = "5 (Least important)"
)

translate_column <- function(col) {
  ifelse(col %in% names(trans_dict), trans_dict[col], col)
}

for(i in 1:ncol(turkish_data)) {
  turkish_data[[i]] <- translate_column(turkish_data[[i]])
}

write.csv(turkish_data, "turkish_separated_translated.csv", row.names = FALSE)

colnames(turkish_data)
colnames(english_data)

turkish_data <- turkish_data[, -1]
english_data <- english_data[, -1]

colnames(english_data) <- colnames(turkish_data)

final_data<- rbind(turkish_data, english_data)

library(dplyr)
glimpse(final_data)

library(tidyverse)



library(forcats)
library(stringr)
library(readr)

likert_labels <- c("Strongly disagree", "Disagree", "Neutral", "Agree", "Strongly agree")

data_clean <- final_data %>% 
  
  # --- STEP 1: Fix Ranking Columns ---
  mutate(
    across(
      contains("Please order the following"),
      ~ parse_number(as.character(.x))
    )
  ) %>%
  
  # ----------- ADDED YEAR STUFF (ONLY THIS PART) -----------
mutate(
  `3- What is your current year of study?` =
    str_squish(as.character(`3- What is your current year of study?`))
) %>%
  mutate(
    `3- What is your current year of study?` = case_when(
      `3- What is your current year of study?` %in% c("Preparatory","1st year","2nd year","3rd year","4th year")
      ~ `3- What is your current year of study?`,
      TRUE ~ "Non-Undergrad"
    )
  ) %>%
  # ---------------------------------------------------------

# --- STEP 2: Base Categorical Variables ---
mutate(
  `Bu formu hangi dilde doldurmak istersiniz?\nWhich language would you like to complete this form in?` = factor(
    `Bu formu hangi dilde doldurmak istersiniz?\nWhich language would you like to complete this form in?`,
    levels = c("Türkçe -Turkish", "İngilizce-English")
  ),
  
  `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` = factor(
    `1- Please select the name of your department or major. (If you have a double major, please select your main department.)`
  ),
  
  # Year (now includes Non-Undergrad)
  `3- What is your current year of study?` = factor(
    `3- What is your current year of study?`,
    levels = c("Preparatory", "1st year", "2nd year", "3rd year", "4th year", "Non-Undergrad"),
    ordered = TRUE
  ),
  
  `4- Please indicate your age group.` = factor(
    `4- Please indicate your age group.`,
    levels = c("Under 18", "18–20", "21–23", "24 and over"),
    ordered = TRUE
  ),
  
  `5- Which of the following best describes your gender identity?` = factor(
    `5- Which of the following best describes your gender identity?`
  ),
  
  `7- Are you currently employed, interning, or working freelance?` = factor(
    `7- Are you currently employed, interning, or working freelance?`,
    levels = c("No", "Yes, as an intern", "Yes, part-time", "Yes, full-time", "Yes, freelance")
  )
) %>% 
  
  # --- STEP 3: Likert Questions ---
  mutate(
    across(
      c(
        `8-I believe my university education adequately prepares me for employment. (1 = Strongly disagree → 5 = Strongly agree)`,
        `9- I am satisfied with the career support and resources provided by my university. (1 = Strongly disagree → 5 = Strongly agree)`,
        `10- I feel confident in my technical and professional skills (e.g., programming, communication, teamwork).`,
        `19- Financial security is the single most important aspect when choosing my first job (1 = Strongly disagree → 5 = Strongly agree)`,
        `20- I expect to stay at my first job for less than three years.`,
        `21- I believe my diploma alone will be enough for me to find a good job. (1 = Strongly disagree → 5 = Strongly agree)`,
        `22- I think I might need a second job to maintain a decent standard of living. (1 = Strongly disagree → 5 = Strongly agree)`,
        `23- Having flexibility (remote work, flexible hours) is a priority for me in a job. (1 = Strongly disagree → 5 = Strongly agree)`,
        `24- I am open to considering work opportunities abroad. (1 = Strongly disagree → 5 = Strongly agree)`,
        `25- I think work–life balance is more important than career prestige. (1 = Strongly disagree → 5 = Strongly agree)`,
        `26- I would accept a lower salary for a job that aligns with my values. (1 = Strongly disagree → 5 = Strongly agree)`,
        `27- I believe I need to work more than 40 hours a week to earn a high salary. (1 = Strongly disagree → 5 = Strongly agree)`,
        `28- I believe my long-term career success depends more on luck than on hard work. (1 = Strongly disagree → 5 = Strongly agree)`
      ),
      ~ factor(
        as.integer(.x),
        levels = c(1, 2, 3, 4, 5), 
        labels = likert_labels, 
        ordered = TRUE
      )
    ),
    
    `11- How often do you participate in skill-building activities (courses, workshops, certificates, competitions)?` = factor(
      `11- How often do you participate in skill-building activities (courses, workshops, certificates, competitions)?`,
      levels = c("Never", "Rarely", "Sometimes", "Often", "Very often"),
      ordered = TRUE
    ),
    
    `12- How active are you in building your professional network (career events, LinkedIn, mentorship, etc.)?` = factor(
      `12- How active are you in building your professional network (career events, LinkedIn, mentorship, etc.)?`,
      levels = c("Not active at all", "Rarely active", "Somewhat active", "Active", "Very active"),
      ordered = TRUE
    ),
    
    across(
      contains("How confident") | contains("How certain"),
      ~ factor(
        as.integer(.x),
        levels = c(1, 2, 3, 4, 5),
        ordered = TRUE
      )
    )
  ) %>% 
  
  # --- STEP 4: Faculty Variable ---
  mutate(
    faculty = case_when(
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Architecture", "City and Regional Planning", "Industrial Design") ~ "Faculty of Architecture",
      
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Biological Sciences", "Chemistry", "History", "Mathematics", "Philosophy", "Physics", "Psychology", "Sociology", "Statistics", "Biology", "Molecular Biology and Genetics") ~ "Faculty of Arts and Science",
      
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Business Administration", "Economics", "International Relations", "Political Science and Public Administration") ~ "Faculty of Economic and Administrative Sciences",
      
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Computer Education and Instructional Technology", "Educational Sciences", "Elementary and Early Childhood Education", "Foreign Language Education", "Physical Education and Sports", "Mathematics and Science Education", "Mathematics Education", "English Language Teaching", "Chemistry Education", "Physics Education") ~ "Faculty of Education",
      
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Aerospace Engineering", "Chemical Engineering", "Civil Engineering", "Computer Engineering", "Electrical and Electronics Engineering", "Engineering Sciences", "Environmental Engineering", "Food Engineering", "Geological Engineering", "Industrial Engineering", "Mechanical Engineering", "Metallurgical and Materials Engineering", "Mining Engineering", "Petroleum and Natural Gas Engineering") ~ "Faculty of Engineering",
      
      TRUE ~ "Other / Unknown"
    ),
    faculty = factor(faculty)
  )




# Fix GPA for Preparatory students (no NA, just "Not Applicable")

# Keep GPA as ordered factor including "Not Applicable"
# 1. Define the levels EXACTLY as they appear in your screenshot
# Note: I've added "Not Applicable" for your Prep students
gpa_levels_exact <- c(
  "0–2.0", 
  "2.01–2.5", 
  "2.51–3.0", 
  "3.01–3.5", 
  "3.51–4.0", 
  "Not Applicable"
)

data_clean <- data_clean %>%
  mutate(
    # Create a temporary character column to avoid factor errors
    temp_gpa = as.character(`6- Please indicate your current cumulative GPA (on a 4.00 scale).`),
    
    # Apply the Prep student logic
    temp_gpa = case_when(
      `3- What is your current year of study?` == "Preparatory" ~ "Not Applicable",
      TRUE ~ temp_gpa
    ),
    
    # Convert to factor using the EXACT strings from your image
    `6- Please indicate your current cumulative GPA (on a 4.00 scale).` = factor(
      temp_gpa,
      levels = gpa_levels_exact,
      ordered = TRUE
    )
  ) %>%
  select(-temp_gpa)





# 13th question cleaning


# Define the list of valid answers from your image
library(dplyr)

data_clean <- data_clean %>%
  mutate(`13- After completing your degree, what is your primary plan?` = case_when(
    # 1. Seek full-time employment
    `13- After completing your degree, what is your primary plan?` %in% 
      c("Seek full-time employment", "Start a full-time job") ~ "Seek full-time employment",
    
    # 2. Pursue a Master’s or PhD
    `13- After completing your degree, what is your primary plan?` %in% 
      c("Pursue a Master's or PhD", "Pursue a Master’s or PhD") ~ "Pursue a Master’s or PhD",
    
    # 3. Start your own business
    `13- After completing your degree, what is your primary plan?` %in% 
      c("Start your own business", "Start my own business") ~ "Start your own business",
    
    # 4. Take a gap year
    `13- After completing your degree, what is your primary plan?` == "Take a gap year" ~ "Take a gap year",
    
    # Everything else (Askerlik, Evlenmek, Not sure, Seek in Europe, etc.) becomes "Other"
    TRUE ~ "Other"
  ))

# Verify the result
table(data_clean$`13- After completing your degree, what is your primary plan?`)




# 15th question clean

data_clean <- data_clean %>%
  mutate(`15- What do you plan to do during your gap year?` = case_when(
    # 1. Keep empty cells empty
    is.na(`15- What do you plan to do during your gap year?`) | 
      `15- What do you plan to do during your gap year?` == "" ~ `15- What do you plan to do during your gap year?`,
    
    # 2. Keep only the valid categories you want
    `15- What do you plan to do during your gap year?` %in% c(
      "Travel / cultural exchange", 
      "Internship / work experience", 
      "Volunteering", 
      "Learning a new language or skill"
    ) ~ `15- What do you plan to do during your gap year?`,
    
    # 3. Turn unwanted text (like "Yatmak") into "Other"
    TRUE ~ "Other"
  )
  )

table(data_clean$`15- What do you plan to do during your gap year?`)






# 14- What is your main reason for wanting to pursue a Master’s or PhD degree?


library(dplyr)

data_clean <- data_clean %>%
  mutate(`14- What is your main reason for wanting to pursue a Master’s or PhD degree?` = case_when(
    # 1. Preserve NULLs/Empty cells first
    is.na(`14- What is your main reason for wanting to pursue a Master’s or PhD degree?`) | 
      `14- What is your main reason for wanting to pursue a Master’s or PhD degree?` == "" ~ `14- What is your main reason for wanting to pursue a Master’s or PhD degree?`,
    
    # 2. Combine similar answers into your preferred categories
    `14- What is your main reason for wanting to pursue a Master’s or PhD degree?` %in% 
      c("Academic career goal", "Academic career goal (research or teaching position)") ~ "Academic career goal",
    
    `14- What is your main reason for wanting to pursue a Master’s or PhD degree?` %in% 
      c("To gain experience abroad", "To gain international experience", "To settle abroad easier") ~ "To gain international experience",
    
    `14- What is your main reason for wanting to pursue a Master’s or PhD degree?` == 
      "To gain a competitive advantage in the job market" ~ "To gain a competitive advantage in the job market",
    
    `14- What is your main reason for wanting to pursue a Master’s or PhD degree?` == 
      "To gain in-depth knowledge of my field" ~ "To gain in-depth knowledge of my field",
    
    # 3. Everything else that has text (like "Şahsi tatmin") becomes "Other"
    TRUE ~ "Other"
  ))

# Verify the result
table(data_clean$`14- What is your main reason for wanting to pursue a Master’s or PhD degree?`)




#

table(data_clean$`15- What is the most important criteria for you when choosing a graduate program?`)


library(dplyr)

data_clean <- data_clean %>%
  mutate(`15- What is the most important criteria for you when choosing a graduate program?` = case_when(
    # 1. Preserve empty rows
    is.na(`15- What is the most important criteria for you when choosing a graduate program?`) | 
      `15- What is the most important criteria for you when choosing a graduate program?` == "" ~ `15- What is the most important criteria for you when choosing a graduate program?`,
    
    # 2. Group similar and translated answers
    `15- What is the most important criteria for you when choosing a graduate program?` == 
      "University reputation" ~ "University reputation",
    
    `15- What is the most important criteria for you when choosing a graduate program?` %in% 
      c("Location (country / city)", "Konum (ülke / şehir)") ~ "Location (country / city)",
    
    `15- What is the most important criteria for you when choosing a graduate program?` %in% 
      c("Scholarship or financial support opportunities", 
        "Scholarship / financial support", 
        "Burs / finansal destek olanakları") ~ "Scholarship / financial support",
    
    `15- What is the most important criteria for you when choosing a graduate program?` %in% 
      c("Advisor quality", "Danışman kalitesi") ~ "Advisor quality",
    
    `15- What is the most important criteria for you when choosing a graduate program?` %in% 
      c("Job opportunities", "İş olanakları") ~ "Career opportunities",
    
    # 3. Everything else (Ankara..., Hepsi, i didnt choose) becomes "Other"
    TRUE ~ "Other"
  ))

# Verify results
table(data_clean$`15- What is the most important criteria for you when choosing a graduate program?`)





# 17  What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.



library(dplyr)

data_clean <- data_clean %>%
  mutate(`17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.` = case_when(
    # 1. Preserve NULLs/Empty cells
    is.na(`17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`) ~ NA_character_,
    
    # 2. Standardize ranges (Handling both dots and commas)
    gsub("[.,]", "", `17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`) == "30000–49999" ~ "30,000–49,999",
    gsub("[.,]", "", `17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`) == "50000–69999" ~ "50,000–69,999",
    gsub("[.,]", "", `17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`) == "70000–99999" ~ "70,000–99,999",
    gsub("[.,]", "", `17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`) == "100000+" ~ "100,000+",
    
    # Standardize the lower bound
    trimws(`17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`) %in% c("< 30,000", "<30,000", "< 30.000", "<30.000") ~ "< 30,000",
    
    # 3. Everything else (Prefer not to say, Belirtmek istemiyorum, etc.) becomes "Prefer not to say"
    TRUE ~ "Prefer not to say"
  ))

# Verify results
table(data_clean$`17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`)

#`2-Are you currently enrolled in a double major or minor program?`)


library(dplyr)

data_clean <- data_clean %>%
  mutate(`2-Are you currently enrolled in a double major or minor program?` = case_when(
    # 1. Preserve NULLs
    is.na(`2-Are you currently enrolled in a double major or minor program?`) ~ NA_character_,
    
    # 2. Group "No"
    `2-Are you currently enrolled in a double major or minor program?` == "No" ~ "No",
    
    # 3. Group Double Majors (including the one person doing both)
    `2-Are you currently enrolled in a double major or minor program?` %in% 
      c("Yes, a double major", "Yes, double major", "Evet, hem çift anadal hem yandal yapıyorum") ~ "Yes, double major",
    
    # 4. Group Minors
    `2-Are you currently enrolled in a double major or minor program?` %in% 
      c("Yes, a minor", "Yes, minor") ~ "Yes, minor",
    
    # 5. Catch-all for anything else
    TRUE ~ "Other"
  ))

# Verify results
table(data_clean$`2-Are you currently enrolled in a double major or minor program?`)




table(data_clean$`4- Please indicate your age group.`)
table(data_clean$`4- Please indicate your age group.`)
table(data_clean$`5- Which of the following best describes your gender identity?`)

table(data_clean$`6- Please indicate your current cumulative GPA (on a 4.00 scale).`)
table(data_clean$`7- Are you currently employed, interning, or working freelance?`)
table(data_clean$`8-I believe my university education adequately prepares me for employment. (1 = Strongly disagree → 5 = Strongly agree)`)

table(data_clean$`9- I am satisfied with the career support and resources provided by my university. (1 = Strongly disagree → 5 = Strongly agree)`)

table(data_clean$`10- I feel confident in my technical and professional skills (e.g., programming, communication, teamwork).`)
table(data_clean$`11- How often do you participate in skill-building activities (courses, workshops, certificates, competitions)?`)
table(data_clean$`12- How active are you in building your professional network (career events, LinkedIn, mentorship, etc.)?`)
table(data_clean$`13- After completing your degree, what is your primary plan?`)
table(data_clean$`14- How certain are you about this plan? (1 = Not certain / 5 = Very certain)`)
table(data_clean$`14- How confident are you in finding a job within 6 months after graduation?`)
table(data_clean$`14- How confident are you that this gap year will benefit your future career or education?`)
table(data_clean$`14- How do you plan to finance your business?`)




# 14 14- How do you plan to finance your business?`

library(dplyr)

data_clean <- data_clean %>%
  mutate(`14- How do you plan to finance your business?` = case_when(
    # 1. Preserve empty/NULL rows
    is.na(`14- How do you plan to finance your business?`) | 
      `14- How do you plan to finance your business?` == "" ~ `14- How do you plan to finance your business?`,
    
    # 2. Group and Translate valid categories
    `14- How do you plan to finance your business?` == "Personal savings" ~ "Personal savings",
    
    `14- How do you plan to finance your business?` == "Family or friends support" ~ "Family or friends support",
    
    `14- How do you plan to finance your business?` == "Government or university grants" ~ "Government or university grants",
    
    `14- How do you plan to finance your business?` %in% 
      c("Investors or venture capital", "Yatırımcılar veya girişim sermayesiyle") ~ "Investors or venture capital",
    
    # 3. Everything else (Not sure yet, etc.) becomes "Not sure yet"
    TRUE ~ "Not sure yet"
  ))

# Verify results
table(data_clean$`14- How do you plan to finance your business?`)




table(data_clean$`14- What is your main reason for wanting to pursue a Master’s or PhD degree?`)
table(data_clean$`15- Do you plan to work in a field directly related to your major?`)
table(data_clean$`15- In which sector are you planning to build your business? (Select all options that apply.)`)



#15- In which sector are you planning to build your business? (Select all options that apply.)
library(dplyr)
library(tidyr)
library(stringr)

sector_counts <- data_clean %>%
  select(Sector = `15- In which sector are you planning to build your business? (Select all options that apply.)`) %>%
  filter(!is.na(Sector)) %>%
  # This regex splits by comma ONLY if it's NOT inside parentheses
  separate_rows(Sector, sep = ",\\s*(?![^(]*\\))") %>%
  mutate(Sector = trimws(Sector)) %>%
  # Fix the "Agriculte" typo found in the data
  mutate(Sector = str_replace(Sector, "Agriculte", "Agriculture")) %>%
  count(Sector, name = "Count") %>%
  arrange(desc(Count))

# View the clean results
print(sector_counts)

table(data_clean$`15- What do you plan to do during your gap year?`)
table(data_clean$`15- What is the most important criteria for you when choosing a graduate program?`)
table(data_clean$`15-When do you expect to start implementing this plan?`)

table(data_clean$`16- Where would you ideally like to work five years from now?`)


#16- Where would you ideally like to work five years from now?

library(dplyr)

data_clean <- data_clean %>%
  mutate(`16- Where would you ideally like to work five years from now?` = case_when(
    # 1. Preserve NULLs
    is.na(`16- Where would you ideally like to work five years from now?`) ~ NA_character_,
    
    # 2. Abroad
    `16- Where would you ideally like to work five years from now?` == "Abroad" ~ "Abroad",
    
    # 3. In Turkey - International (Combines Turkey/Türkiye and Company/Firm)
    `16- Where would you ideally like to work five years from now?` %in% 
      c("In Turkey – international company", "In Türkiye – international firm") ~ "In Turkey – international company",
    
    # 4. In Turkey - Local (Combines Turkey/Türkiye)
    `16- Where would you ideally like to work five years from now?` %in% 
      c("In Turkey – local company", "In Türkiye – local company") ~ "In Turkey – local company",
    
    # 5. Own Business / Self-employed (Merged as requested)
    `16- Where would you ideally like to work five years from now?` %in% 
      c("Own business", "Self-employed") ~ "Own business",
    
    # 6. I don't know (Standardizes the apostrophe)
    `16- Where would you ideally like to work five years from now?` %in% 
      c("I don't know", "I don’t know") ~ "I don't know",
    
    # 7. Everything else (any other custom text) becomes Other
    TRUE ~ "Other"
  ))

# Verify results
table(data_clean$`16- Where would you ideally like to work five years from now?`)



table(data_clean$`17- What is your expected net monthly salary for your first full-time job (in TL)? Please specify an approximate range.`)
table(data_clean$`18- Which working style do you prefer for your future job?`)
table(data_clean$`19- Financial security is the single most important aspect when choosing my first job (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`20- I expect to stay at my first job for less than three years.`)
table(data_clean$`21- I believe my diploma alone will be enough for me to find a good job. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`22- I think I might need a second job to maintain a decent standard of living. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`23- Having flexibility (remote work, flexible hours) is a priority for me in a job. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`24- I am open to considering work opportunities abroad. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`25- I think work–life balance is more important than career prestige. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`26- I would accept a lower salary for a job that aligns with my values. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`27- I believe I need to work more than 40 hours a week to earn a high salary. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`28- I believe my long-term career success depends more on luck than on hard work. (1 = Strongly disagree → 5 = Strongly agree)`)
table(data_clean$`29-  Please order the following from 1 (most important) to 5 (least important) according to your priorities. Each number can be used only once. [ Autonomy & independence]`)
table(data_clean$`29-  Please order the following from 1 (most important) to 5 (least important) according to your priorities. Each number can be used only once. [ Career stability]`)
table(data_clean$`29-  Please order the following from 1 (most important) to 5 (least important) according to your priorities. Each number can be used only once. [ High salary & benefits]`)
table(data_clean$`29-  Please order the following from 1 (most important) to 5 (least important) according to your priorities. Each number can be used only once. [ Meaningful work (positive social impact)]`)

table(data_clean$`29-  Please order the following from 1 (most important) to 5 (least important) according to your priorities. Each number can be used only once. [Work–life balance]`)



write.csv(data_clean, "~/Desktop/clean_data.csv", row.names = FALSE)
getwd()



#add the achritevture and education and admin faculties.
data_clean <- data_clean %>%
  mutate(faculty_merged = fct_collapse(faculty,
                                       "Other Faculties" = c("Faculty of Economic and Administrative Sciences", 
                                                             "Faculty of Education", 
                                                             "Faculty of Architecture")
  ))

# Check the new groups

table(data_clean$faculty_merged)


write.csv(data_clean, "~/Desktop/clean_data.csv", row.names = FALSE)
getwd()


