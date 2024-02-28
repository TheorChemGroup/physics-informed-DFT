#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)
library(reshape2)

# Functional colors
#[1] "#E41A1C" "#377EB8" "#4DAF4A" "#984EA3" "#FF7F00" "#A65628"
#[8] "#F781BF" 
# R2SCAN      "black"
# PBE         "darkgreen"
# M06-2X      "deeppink"
# piM06-2X    "darkorange"
# piM06-2X-DL "dodgerblue"

Fx_Fxc_tab <- read.csv("Fx-Fxc.csv", sep=";", header=T)

p <- Fx_Fxc_tab %>%
  filter(s > 0) %>%
  left_join(data.frame(Name=c("PBE", "R2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL"), lw=c(2,1,1,1,1))) %>%
  mutate(alpha=factor(as.character(as.integer(alpha)), levels=c("0","1","1000000000"), labels=c("0", "1", "10^9")),
         var=factor(var, levels=c("Fx","Fxc"),labels=c("F[x]","F[xc]")),
         Name=factor(Name, levels=c("PBE", "R2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL"))) %>%
  ggplot(aes(x=s, y=val, linetype=alpha, color=Name, linewidth=lw)) +
    geom_hline(yintercept=1.804, color="blue", linewidth=0.8) +
    geom_line(alpha=1) +
    coord_cartesian(ylim=c(-0.2,3.3), xlim=c(0,5), expand=F) +
    scale_x_continuous(expression(paste("Normed gradient, ", italic(s)))) +
    scale_y_continuous("Enhancement factor", breaks=seq(-5,5,1)) +
    facet_wrap(~var, labeller = label_parsed) +
    scale_color_manual("Functional", values=c("forestgreen", "black","deeppink", "darkorange1", "dodgerblue"),
                                     breaks=c("PBE","R2SCAN","M06-2X","piM06-2X","piM06-2X-DL"),
                                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL")) +
    scale_linetype_manual(expression(alpha), labels = c("0", "1", expression(10^9)), values = c("solid", "dashed", "dotted")) +
    scale_linewidth_identity() +
    geom_hline(yintercept=0, color="gray80", linewidth=0.8) +
    theme_bw() +
    theme(legend.position="bottom") +
    guides(linewidth="none", color="legend", linetype="legend")

ggsave("Fig_fx_fxc-cutted.png", p, units="cm", dpi=1000, width=19, height=10*19/18)

p <- Fx_Fxc_tab %>%
  filter(s > 0) %>%
  left_join(data.frame(Name=c("PBE", "R2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL"), lw=c(2,1,1,1,1))) %>%
  mutate(alpha=factor(as.character(as.integer(alpha)), levels=c("0","1","1000000000"), labels=c("0", "1", "10^9")),
         var=factor(var, levels=c("Fx","Fxc"),labels=c("F[x]","F[xc]")),
         Name=factor(Name, levels=c("PBE", "R2SCAN", "M06-2X", "piM06-2X", "piM06-2X-DL"))) %>%
  ggplot(aes(x=s, y=val, linetype=alpha, color=Name, linewidth=lw)) +
    geom_line(alpha=1) +
    coord_cartesian(ylim=c(-4,5), xlim=c(0,5), expand=F) +
    scale_x_continuous(expression(paste("Normed gradient, ", italic(s)))) +
    scale_y_continuous("Enhancement factor", breaks=seq(-5,5,1)) +
    facet_wrap(~var, labeller = label_parsed) +
    scale_color_manual("Functional", values=c("forestgreen", "black","deeppink", "darkorange1", "dodgerblue"),
                                     breaks=c("PBE","R2SCAN","M06-2X","piM06-2X","piM06-2X-DL"),
                                     labels=c("PBE","r2SCAN","M06-2X","piM06-2X","piM06-2X-DL")) +
    scale_linetype_manual(expression(alpha), labels = c("0", "1", expression(10^9)), values = c("solid", "dashed", "dotted")) +
    scale_linewidth_identity() +
    geom_hline(yintercept=0, color="gray80", linewidth=0.8) +
    theme_bw() +
    theme(legend.position="bottom") +
    guides(linewidth="none", color="legend", linetype="legend")

ggsave("Fig_fx_fxc-full.png", p, units="cm", dpi=1000, width=19, height=10*19/18)
