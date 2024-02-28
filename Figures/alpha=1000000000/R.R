#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(reshape2)
library(tidyr)

functional_names <- data.frame(Name_orig=c("gga_x_pbe", "mgga_x_r2scan", "HYB_MGGA_X_M06_2X",
                                           "rhoPBE0_enerPBE0_OMEGA_cheb_old0000000", "rhoPBE0_enerPBE0_OMEGA_cheb_old0007596", "rhoPBE0_enerPBE0_OMEGA_cheb_old0066987", "rhoPBE0_enerPBE0_OMEGA_cheb_old0178606", "rhoPBE0_enerPBE0_OMEGA_cheb_old0328990", "rhoPBE0_enerPBE0_OMEGA_cheb_old0500000", "rhoPBE0_enerPBE0_OMEGA_cheb_old0671010", "rhoPBE0_enerPBE0_OMEGA_cheb_old0821394", "rhoPBE0_enerPBE0_OMEGA_cheb_old0933013", "rhoPBE0_enerPBE0_OMEGA_cheb_old0992404", "rhoPBE0_enerPBE0_OMEGA_cheb_old1000000",
                                           "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0000000", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0007596", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0066987", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0178606", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0328990", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0500000", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0671010", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0821394", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0933013", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_0992404", "rhoPBE0_enerPBE0_OMEGA_cheb_old_d3bj_1000000"),
                               Name=c("PBE", "r2SCAN", "M06-2X",
                                      "piM06-2X(Ω=0.000000)", "piM06-2X(Ω=0.007596)", "piM06-2X(Ω=0.066987)", "piM06-2X(Ω=0.178606)", "piM06-2X(Ω=0.328990)", "piM06-2X(Ω=0.500000)", "piM06-2X(Ω=0.671010)", "piM06-2X(Ω=0.821394)", "piM06-2X(Ω=0.933013)", "piM06-2X(Ω=0.992404)", "piM06-2X(Ω=1.000000)",
                                      "piM06-2X-DL(Ω=0.000000)", "piM06-2X-DL(Ω=0.007596)", "piM06-2X-DL(Ω=0.066987)", "piM06-2X-DL(Ω=0.178606)", "piM06-2X-DL(Ω=0.328990)", "piM06-2X-DL(Ω=0.500000)", "piM06-2X-DL(Ω=0.671010)", "piM06-2X-DL(Ω=0.821394)", "piM06-2X-DL(Ω=0.933013)", "piM06-2X-DL(Ω=0.992404)", "piM06-2X-DL(Ω=1.000000)"),
                               omega=c(NA, NA, NA,
                                       0.000000, 0.007596, 0.066987, 0.178606, 0.328990, 0.500000, 0.671010, 0.821394, 0.933013, 0.992404, 1.000000,
                                       0.000000, 0.007596, 0.066987, 0.178606, 0.328990, 0.500000, 0.671010, 0.821394, 0.933013, 0.992404, 1.000000),
                               Family=c("PBE", "r2SCAN", "M06-2X",
                                        "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X", "piM06-2X",
                                        "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL", "piM06-2X-DL"))

data <- read.csv("Fx_Fxc.csv", header=T, sep=",") %>%
  left_join(functional_names) %>%
  select(-Name_orig)
p <- data %>%
  filter(s > 0) %>%
  filter(alpha != 100) %>%
  drop_na() %>%
  mutate(alpha=factor(as.character(as.integer(alpha)), levels=c("0","1","100","1000000000"), labels=c("0", "1", "100", "10^9")),
         Type=factor(Type, levels=c("Fx","Fxc"), labels=c("F[x]","F[xc]")),
         omega=factor(omega)) %>%
  ggplot(aes(x=s, y=Value, color=omega, linetype=alpha)) +
    geom_hline(yintercept=0, color="gray80", linewidth=0.8) +
    geom_line() +
    scale_x_continuous(expression(paste("Normed gradient, ", italic(s)))) +
    scale_y_continuous("Enhancement factor", breaks=seq(-5,5,1)) +
    facet_grid(Family~Type) +#, labeller = label_parsed) +
    scale_color_manual(expression(Omega), values = rainbow(11)) +
    scale_linetype_manual(expression(alpha), labels = c("0", "1", expression(10^9)), values =  rev(c("solid", "dashed", "dotted"))) +
    theme_bw() +
    theme(legend.position="bottom")

ggsave("Fig-omega.png", p, units="cm", width=18, height=20, dpi=1000)
