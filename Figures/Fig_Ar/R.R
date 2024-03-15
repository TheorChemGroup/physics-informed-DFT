#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)
library(reshape2)

Ar2_tab <- read.csv("Ar2_Fx_Fxc.csv", sep=",", header=T) %>% select(-X)
Ar2_plot <- Ar2_tab %>%
  filter(!Name%in%c("r2SCAN")) %>% 
  mutate(Type=factor(Type, levels=c("Fx","Fxc"),labels=c("F[x]","F[xc]")),
         Name=factor(Name, levels=c("r2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL", "M06-2X-Ω100", "PBE"))) %>%
  ggplot() +
    geom_line(aes(x=z, y=Value, color=Name, linewidth=Name, linetype=Name),
              alpha=0.7) +
    coord_cartesian(ylim=c(0,3), xlim=c(-7,7), expand=F) +
    scale_x_continuous("Position, Angstrom", breaks=c(seq(-6,6,1.5)), minor_breaks=seq(-7,7,0.5)) +
    scale_y_continuous("Enhancement factor") +
    scale_color_manual("Functional", values=c("black", "#e41a1c","deeppink", "darkorange1", "dodgerblue", "green"),
                                     breaks=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100"),
                                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100")) +
    scale_linetype_manual("Functional", values=c("solid", "solid", "solid", "solid", "solid", "solid"),
                     breaks=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100"),
                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100")) +
    scale_linewidth_manual("Functional", values=c(0.7, 1.2, 1.2, 1.2, 1.2, 1.2),
                        breaks=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100"),
                        labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100")) +
    facet_wrap(~Type, labeller = label_parsed) +
    theme_bw() +
    theme(legend.position="bottom") +
    guides(linewidth="legend", color="legend")
Ar2_plot
ggsave("FigAr2.png", Ar2_plot, units="cm", dpi=1000, width=18, height=10)
