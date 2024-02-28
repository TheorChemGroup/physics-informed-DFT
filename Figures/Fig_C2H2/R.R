#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)
library(reshape2)

C2H2_tab <- read.csv("C2H2_Fx_Fxc.csv", sep=",", header=T) %>% select(-X)
p <- C2H2_tab %>%
  left_join(data.frame(Name=c("PBE", "r2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL", "M06-2X-Ω100"), lw=c(2,1,1,1,1,1)*0.5)) %>%
  mutate(Type=factor(Type, levels=c("Fx","Fxc"),labels=c("F[x]","F[xc]")),
         Name=factor(Name, levels=c("PBE", "r2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL", "M06-2X-Ω100"))) %>%
  ggplot(aes(x=z, y=Value, color=Name, linewidth=lw)) +
    geom_line() +
    coord_cartesian(ylim=c(0,3), xlim=c(-7,7), expand=F) +
    scale_x_continuous("Position, Angstrom", breaks=c(seq(-6,6,1.5)), minor_breaks=seq(-7,7,0.5)) +
    scale_y_continuous("Enhancement factor") +
    scale_color_manual("Functional", values=c("forestgreen", "black","deeppink", "darkorange1", "dodgerblue", "yellow"),
                                     breaks=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100"),
                                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100")) +
    scale_linewidth_identity() +
    facet_wrap(~Type, labeller = label_parsed) +
    theme_bw() +
    theme(legend.position="bottom") +
    guides(linewidth="none", color="legend")

ggsave("FigC2H2.png", p, units="cm", dpi=1000, width=18, height=10)

C2H2_tab_baseline <- C2H2_tab %>%
  filter(Name == "PBE") %>%
  select(z, Value, Type) %>%
  rename("baseline" = "Value")

p <- C2H2_tab %>%
  left_join(C2H2_tab_baseline, by=c("z", "Type")) %>%
  mutate(diff = Value - baseline) %>%
  select(-Value, -baseline) %>%
  left_join(data.frame(Name=c("PBE", "r2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL", "M06-2X-Ω100"), lw=c(2,1,1,1,1,1)*0.5)) %>%
  mutate(Type=factor(Type, levels=c("Fx","Fxc"),labels=c("F[x]","F[xc]")),
         Name=factor(Name, levels=c("PBE", "r2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL", "M06-2X-Ω100"))) %>%
  ggplot(aes(x=z, y=diff, color=Name, linewidth=lw)) +
    geom_line() +
    coord_cartesian(ylim=c(-1,1), xlim=c(-7,7), expand=F) +
    scale_x_continuous("Position, Angstrom", breaks=c(seq(-6,6,1.5)), minor_breaks=seq(-7,7,0.5)) +
    scale_y_continuous(expression("EF - EF"^"PBE")) +
    scale_color_manual("Functional", values=c("forestgreen", "black","deeppink", "darkorange1", "dodgerblue", "yellow"),
                                     breaks=c("PBE", "r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100"),
                                     labels=c("PBE", "r2SCAN","M06-2X","piM06-2X","piM06-2X-DL", "M06-2X-Ω100")) +
    scale_linewidth_identity() +
    facet_wrap(~Type, labeller = label_parsed) +
    theme_bw() +
    theme(legend.position="bottom") +
    guides(linewidth="none", color="legend")

ggsave("FigC2H2-baseline.png", p, units="cm", dpi=1000, width=18, height=10)
