#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(reshape2)

data <- read.csv("data.csv", header=T, sep=";") %>%
  melt(id.vars=c("isLine","Xval", "Name", "size")) %>%
  mutate(variable = factor(variable, levels=c("diet30","Mol_den")),
         Func = factor(Name, levels=c("PBE0","PBE0-D3(BJ)","PBE-2X","M06-2X","piM06-2X","piM06-2X-DL")))
p <- data %>%
  arrange(Name) %>%
  filter(isLine == 0) %>%
  ggplot(aes(x=Xval,y=value, color=Name)) +
    geom_line() +
    geom_point() +
    geom_point(data = data %>% filter(size==5), size=5, shape=1, show_guide=F) +
    geom_hline(data = data %>% filter(isLine == 1), aes(yintercept = value, color=Name)) +
    coord_cartesian(xlim=c(0,1)) +
    scale_y_log10("", breaks=c(seq(0.0,1.0,0.1),seq(1,10,1))) +
    scale_x_continuous(expression(Omega), breaks=seq(0,1,0.2)) +
    facet_wrap(~variable, scales="free", labeller=as_labeller(c("Mol_den" = "Overall RANE on molecules", "diet30" = "WTMAD-2, kcal/mol"))) +
    scale_color_manual("Functional", values=c("seagreen","darkolivegreen3","springgreen2","deeppink","darkorange1","dodgerblue"),
                                     breaks=c("PBE0","PBE0-D3(BJ)","PBE-2X","M06-2X","piM06-2X","piM06-2X-DL"),
                                     labels=c("PBE0","PBE0-D3(BJ)","PBE-2X-D3(BJ)","M06-2X","piM06-2X","piM06-2X-DL")) +
    theme_bw() +
    theme(legend.position="bottom") +
    guides(colour = guide_legend(nrow = 1), size="none", shape="none")

ggsave("Fig1.png", p, units="cm", width=18, height=10, dpi=1000)
