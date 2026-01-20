library(readxl)
df <-  read_xlsx("~/Desktop/datadraft.xlsx") 



is_turkish <- df[, 2] == "Türkçe -Turkish"
is_english <- df[, 2] == "İngilizce-English"

# 3. Create the separated data frames
# syntax: df[ rows_to_keep, columns_to_keep ]

# Turkish: Use "is_turkish" rows, and columns 1 through 43
turkish_data <- df[is_turkish, 1:43]

# English: Use "is_english" rows, and columns 1, 2, and 44 through 84
# c(1, 2, 44:84) combines them into one list of columns
english_data <- df[is_english, c(1, 2, 44:84)]

# 4. Save
write.csv(turkish_data, "turkish_separated.csv", row.names = FALSE)
write.csv(english_data, "english_separated.csv", row.names = FALSE)

colnames(turkish_data)
colnames(english_data)




# 1. Read the files
# We read the English file just to get the correct column headers

# 2. Rename Columns
# We apply the English column names to the Turkish dataset
# (Assuming columns align perfectly after the split, which they should)
colnames(turkish_data) <- colnames(english_data)

# 3. Define the Translation Dictionary
# A named vector where 'name' is the Turkish phrase and 'value' is the English translation
trans_dict <- c(
  # Departments
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
  
  # Standard Responses
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
  
  # Year & Demographics
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
  
  # Frequencies
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
  
  # Plans & Reasons
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
  
  # Business / Work Specifics
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
  
  # Location & Work Style
  "Türkiye’de – yerel firma" = "In Turkey – local company",
  "Türkiye’de – uluslararası firma" = "In Turkey – international company",
  "Yurtdışında" = "Abroad",
  "Kendi işimde" = "Own business",
  "Bilmiyorum" = "I don't know",
  "Hibrit" = "Hybrid",
  "Ofiste" = "In-office",
  "Tamamen uzaktan" = "Fully remote",
  
  # Ranking
  "1 (En önemli)" = "1 (Most important)",
  "5 (En az önemli)" = "5 (Least important)"
)

# 4. Apply Translation
# We define a function to translate a single column
translate_column <- function(col) {
  # Map values using the dictionary
  # If a value is not in the dictionary, keep the original value (unname helps return a clean vector)
  ifelse(col %in% names(trans_dict), trans_dict[col], col)
}

# Apply to all columns
# We iterate over every cell effectively, but vectorized per column
for(i in 1:ncol(turkish_data)) {
  turkish_data[[i]] <- translate_column(turkish_data[[i]])
}

# 5. Save the translated file
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
library(tidyverse)

clean_data <- final_data %>%
  mutate(
    gpa = case_when(
      `3- What is your current year of study?` == "Preparatory" ~ "Not Applicable",
      TRUE ~ as.character(`6- Please indicate your current cumulative GPA (on a 4.00 scale).`)
    ))




class(clean_data$gpa)



colnames(clean_data)

library(dplyr)
library(forcats)

library(dplyr)
library(stringr)
library(readr) # Needed for parse_number

likert_labels <- c("Strongly disagree", "Disagree", "Neutral", "Agree", "Strongly agree")


data_clean$`3- What is your current year of study?` <- factor(ifelse(stringr::str_squish(as.character(clean_data$`3- What is your current year of study?`)) %in% c("Preparatory","1st year","2nd year","3rd year","4th year"), stringr::str_squish(as.character(clean_data$`3- What is your current year of study?`)), "Non-Undergrad"), levels = c("Preparatory","1st year","2nd year","3rd year","4th year","Non-Undergrad"), ordered = TRUE)
data_clean <- clean_data %>%
  
  # --- STEP 1: Fix Ranking Columns (Extract numbers from text like "1 (Most important)") ---
  mutate(
    across(
      contains("Please order the following"),
      ~ parse_number(as.character(.x)) # Pulls '1' out of '1 (Most important)'
    )
  ) %>%
  
  mutate(
    `3- What is your current year of study?` =
      str_squish(as.character(`3- What is your current year of study?`))
  ) %>%
  mutate(
    `3- What is your current year of study?` =
      str_squish(as.character(`3- What is your current year of study?`))
  ) %>%
  mutate(
    `3- What is your current year of study?` = case_when(
      `3- What is your current year of study?` %in% c("Preparatory","1st year","2nd year","3rd year","4th year")
      ~ `3- What is your current year of study?`,
      TRUE ~ "Non-Undergrad"
    ), 
    `3- What is your current year of study?` = forcats::fct_na_value_to_level(`3- What is your current year of study?`, level = "Non-Undergrad")
  ) %>%
  
  
  
  # --- STEP 2: Base Categorical Variables ---
  mutate(
    
    `Bu formu hangi dilde doldurmak istersiniz?\nWhich language would you like to complete this form in?` = factor(
      `Bu formu hangi dilde doldurmak istersiniz?\nWhich language would you like to complete this form in?`,
      levels = c("Türkçe -Turkish", "İngilizce-English")
    ),
    
    # Department
    `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` = factor(
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)`
    ),
    
    # Year
    `3- What is your current year of study?` =
      factor(`3- What is your current year of study?`,
             levels = c("Preparatory","1st year","2nd year","3rd year","4th year","Non-Undergrad"),
             ordered = TRUE),,
    
    # Age
    `4- Please indicate your age group.` = factor(
      `4- Please indicate your age group.`,
      levels = c("Under 18", "18–20", "21–23", "24 and over"),
      ordered = TRUE
    ),
    
    # Gender
    `5- Which of the following best describes your gender identity?` = factor(
      `5- Which of the following best describes your gender identity?`
    ),
    
    # Employment
    `7- Are you currently employed, interning, or working freelance?` = factor(
      `7- Are you currently employed, interning, or working freelance?`,
      levels = c("No", "Yes, as an intern", "Yes, part-time", "Yes, full-time", "Yes, freelance")
    )
  ) %>% 
  
  # --- STEP 3: Likert Questions (Force to Integer first to match levels) ---
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
        as.integer(.x),   # <--- FIX: Forces "1" (text) to 1 (number)
        levels = c(1, 2, 3, 4, 5), 
        labels = likert_labels, 
        ordered = TRUE
      )
    ),
    
    # Frequency
    `11- How often do you participate in skill-building activities (courses, workshops, certificates, competitions)?` = factor(
      `11- How often do you participate in skill-building activities (courses, workshops, certificates, competitions)?`,
      levels = c("Never", "Rarely", "Sometimes", "Often", "Very often"),
      ordered = TRUE
    ),
    
    # Networking
    `12- How active are you in building your professional network (career events, LinkedIn, mentorship, etc.)?` = factor(
      `12- How active are you in building your professional network (career events, LinkedIn, mentorship, etc.)?`,
      levels = c("Not active at all", "Rarely active", "Somewhat active", "Active", "Very active"),
      ordered = TRUE
    ),
    
    # Confidence questions (1-5 Scale)
    across(
      contains("How confident") | contains("How certain"),
      ~ factor(
        as.integer(.x), # <--- FIX: Forces text numbers to integers
        levels = c(1, 2, 3, 4, 5),
        ordered = TRUE
      )
    )
  ) %>% 
  
  # --- STEP 4: Faculty Variable ---
  mutate(
    faculty = case_when(
      # Architecture
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Architecture", "City and Regional Planning", "Industrial Design") ~ "Faculty of Architecture",
      
      # Arts & Science
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Biological Sciences", "Chemistry", "History", "Mathematics", "Philosophy", "Physics", "Psychology", "Sociology", "Statistics", "Biology", "Molecular Biology and Genetics") ~ "Faculty of Arts and Science",
      
      # FEAS
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Business Administration", "Economics", "International Relations", "Political Science and Public Administration") ~ "Faculty of Economic and Administrative Sciences",
      
      # Education
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Computer Education and Instructional Technology", "Educational Sciences", "Elementary and Early Childhood Education", "Foreign Language Education", "Physical Education and Sports", "Mathematics and Science Education", "Mathematics Education", "English Language Teaching", "Chemistry Education", "Physics Education") ~ "Faculty of Education",
      
      # Engineering
      `1- Please select the name of your department or major. (If you have a double major, please select your main department.)` %in% c("Aerospace Engineering", "Chemical Engineering", "Civil Engineering", "Computer Engineering", "Electrical and Electronics Engineering", "Engineering Sciences", "Environmental Engineering", "Food Engineering", "Geological Engineering", "Industrial Engineering", "Mechanical Engineering", "Metallurgical and Materials Engineering", "Mining Engineering", "Petroleum and Natural Gas Engineering") ~ "Faculty of Engineering",
      
      TRUE ~ "Other / Unknown"
    ),
    faculty = factor(faculty)) %>%
  mutate(`6- Please indicate your current cumulative GPA (on a 4.00 scale).` = case_when(
    `3- What is your current year of study?` == "Preparatory" ~ "Not Applicable",
    TRUE ~ as.character(`6- Please indicate your current cumulative GPA (on a 4.00 scale).`)
  ))

# Verify the result
unique(data_clean$`8-I believe my university education adequately prepares me for employment. (1 = Strongly disagree → 5 = Strongly agree)`)


# Check what ranges exist in your data first
unique(clean_data$`6- Please indicate your current cumulative GPA (on a 4.00 scale).`)

# Define the order (Lowest -> Highest)
# IMPORTANT: Update these strings to match your data EXACTLY (including spaces)
gpa_levels <- c(
  "0.00-1.99", 
  "2.00-2.49", 
  "2.50-2.99", 
  "3.00-3.50", 
  "3.51-4.0",  # Matches your image
  "3.51-4.00"  # Add variations if typos exist in data
)

data_clean <- data_clean %>%
  mutate(
    # 1. Clean the logic: Prep Students get NA, everyone else keeps their text
    `6- Please indicate your current cumulative GPA (on a 4.00 scale).` = case_when(
      `3- What is your current year of study?` == "Preparatory" ~ NA_character_,
      TRUE ~ as.character(`6- Please indicate your current cumulative GPA (on a 4.00 scale).`)
    ),
    
    # 2. Convert to Ordered Factor
    `6- Please indicate your current cumulative GPA (on a 4.00 scale).` = factor(
      `6- Please indicate your current cumulative GPA (on a 4.00 scale).`,
      levels = gpa_levels, 
      ordered = TRUE
    )
  )


