library("tidyverse")

performance_data = read_csv("./HPC_iotest/data/io_performance_data.csv")
performance_data = select(performance_data,
                          computer:time)  %>%
mutate(computer = case_when(computer == "computerome" ~ "Computerome",
                            computer == "pupil" ~ "Pupil",
                            computer == "laptop_wsl" ~ "Laptop (WSL)",
                            computer == "laptop_powershell" ~ "Laptop (Powershell)"),
       computer = factor(computer,
                         levels = c("Computerome", "Pupil",
                                    "Laptop (WSL)", "Laptop (Powershell)")),
       method = case_when(method == "method1_forlineinfile.py" ~ "for line in file",
                          method == "method2_whileloop.py" ~ "while loop",
                          method == "method3_forlineinfile_binary.py" ~ "for line in file \n (binary)",
                          method == "method4_chunk_10000.py" ~ "chunk (10000)",
                          method == "method4_chunk_100000.py" ~ "chunk (100000)",
                          method == "poweshellcopy" ~ "windows copy",
                          method == "unixcopy" ~ "unix copy"),
       method = factor(method,
                       levels = c("for line in file",
                                  "for line in file \n (binary)",
                                  "chunk (10000)",
                                  "chunk (100000)",
                                  "while loop",
                                  "unix copy",
                                  "windows copy")))


  
ggplot(data = performance_data,
       mapping = aes(
         x = time,
         fill = method)) +
  geom_density(alpha = 0.5,
               outline.type = "full") +
  xlim(0, 26.25) +
  # xlim(0, 88) +
  facet_grid(rows = vars(computer),
             scales="free_y") +
  scale_y_continuous(breaks = NULL) +
  theme_minimal()  +
  theme(panel.border = element_rect(colour = "grey",
                                    fill=NA,
                                    size=1),
        legend.position = "bottom") +
  labs(title = "Distribution of time spent for each method, stratified by computer",
       subtitle = "(zoomed in to exclude the slower methods on the laptop)",
       x = "Time (seconds)",
       y = "")



ggplot(data = performance_data,
       mapping = aes(
         x = run,
         y = time,
         color = method)) +
  geom_line(alpha = 0.8) +
  facet_wrap(vars(computer)) +
  theme_minimal() +
  theme(panel.border = element_rect(colour = "lightgrey", fill=NA),
        legend.position = "bottom") +
  labs(title = "Time spent per run for each method, stratified by computer",
       x = "Run (n)",
       y = "Time (seconds)")



performance_data %>% 
  group_by(computer, 
           method,
           .add = TRUE) %>% 
  summarise(time = mean(time)) %>% 
  ggplot(mapping = aes(x = method,
                       y = time,
                       fill = method)) +
  geom_col(alpha = 0.5) +
  facet_grid(cols = vars(computer)) +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 70, 
                                   hjust=1),
        panel.border = element_rect(colour = "lightgrey", fill=NA)) +
  labs(title = "Average time spent for each method, stratified by computer",
       x = "Method",
       y = "Time (seconds)")


