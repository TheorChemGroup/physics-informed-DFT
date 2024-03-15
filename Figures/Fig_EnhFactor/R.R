#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)
library(reshape2)
library(tidyverse)

# Functional colors
#[1] "#E41A1C" "#377EB8" "#4DAF4A" "#984EA3" "#FF7F00" "#A65628"
#[8] "#F781BF" 
# R2SCAN      "black"
# PBE         "darkgreen"
# M06-2X      "deeppink"
# piM06-2X    "darkorange"
# piM06-2X-DL "dodgerblue"

Fx_Fxc_tab <- read.csv("Fx-Fxc.csv", sep=";", header=T) %>% 
  filter(s > 0, !Name%in%c("R2SCAN")) %>%
  mutate(alpha=factor(as.character(as.integer(alpha)), levels=c("1000000000","1","0")),
    var=factor(var, levels=c("Fx","Fxc"),labels=c("F[x]","F[xc]")),
    Name=factor(Name, levels=c("R2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL", "PBE")))

Fx_Fxc_plot <- Fx_Fxc_tab %>%
  ggplot() +
  geom_hline(yintercept=0, color="gray80", linewidth=0.8) +
  geom_hline(yintercept=1.804, color="grey60", linewidth=0.8) +
  geom_text(label="Lieb-Oxford bound", x=2.5, y=1.9, color="grey60",
            inherit.aes = F) +
  geom_line(aes(x=s, y=val, linetype=alpha, linewidth=Name, color=Name), 
            alpha=0.7) +
  coord_cartesian(ylim=c(-0.2,3.3), xlim=c(0,5), expand=F) +
  scale_x_continuous(expression(paste("Normed gradient, ", italic(s)))) +
  scale_y_continuous("Enhancement factor", breaks=seq(-5,5,1)) +
  facet_wrap(~var, labeller = label_parsed) +
  scale_color_manual("Functional", 
                     values=c("black", "#e41a1c","deeppink", "darkorange1", "dodgerblue"),
                     #values=c("#4daf4a", "#e41a1c","#984ea3", "darkorange1", "dodgerblue"),
                     breaks=c("PBE","R2SCAN","M06-2X","piM06-2X","piM06-2X-DL"),
                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL")) +
  scale_linewidth_manual("Functional", 
                     values=c(0.7, 1.2, 1.2, 1.2, 1.2),
                     breaks=c("PBE","R2SCAN","M06-2X","piM06-2X","piM06-2X-DL"),
                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL")) +
  scale_linetype_manual(expression(alpha), labels = c("0", "1", expression(10^9)), 
                        breaks=c("0","1","1000000000"),
                        values = c("solid", "44", "22")) +
  theme_bw() +
  theme(legend.position="bottom") +
  guides(linetype="legend")
Fx_Fxc_plot
ggsave("Fig_fx_fxc-clipped.png", Fx_Fxc_plot, units="cm", dpi=1000, width=19, height=10*19/18)

Fx_Fxc_plot_SI <- Fx_Fxc_tab %>%
  ggplot() +
  geom_hline(yintercept=0, color="gray80", linewidth=0.8) +
  geom_hline(yintercept=1.804, color="grey60", linewidth=0.8) +
  geom_text(label="Lieb-Oxford bound", x=2.5, y=2.1, color="grey60",
            inherit.aes = F) +
  geom_line(aes(x=s, y=val, linetype=alpha, linewidth=Name, color=Name), 
            alpha=0.7) +
  coord_cartesian(ylim=c(-4,5), xlim=c(0,5), expand=F) +
  scale_x_continuous(expression(paste("Normed gradient, ", italic(s)))) +
  scale_y_continuous("Enhancement factor", breaks=seq(-5,5,1)) +
  facet_wrap(~var, labeller = label_parsed) +
  scale_color_manual("Functional", 
                     values=c("black", "#e41a1c","deeppink", "darkorange1", "dodgerblue"),
                     #values=c("#4daf4a", "#e41a1c","#984ea3", "darkorange1", "dodgerblue"),
                     breaks=c("PBE","R2SCAN","M06-2X","piM06-2X","piM06-2X-DL"),
                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL")) +
  scale_linewidth_manual("Functional", 
                         values=c(0.7, 1.2, 1.2, 1.2, 1.2),
                         breaks=c("PBE","R2SCAN","M06-2X","piM06-2X","piM06-2X-DL"),
                         labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL")) +
  scale_linetype_manual(expression(alpha), 
                        breaks=c("0","1","1000000000"),
                        labels = c("0", "1", expression(10^9)), 
                        values = c("solid", "44", "22")) +
  theme_bw() +
  theme(legend.position="bottom") +
  guides(linetype="legend")
Fx_Fxc_plot_SI
ggsave("Fig_fx_fxc-SI.png", Fx_Fxc_plot_SI, units="cm", dpi=1000, width=19, height=10*19/18)
