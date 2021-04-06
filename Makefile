# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: irodrigo <irodrigo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 11:00:22 by irodrigo          #+#    #+#              #
#    Updated: 2021/04/06 14:01:21 by irodrigo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ================================ VARIABLES ================================= #

# Error status cleans all files in process
.DELETE_ON_ERROR:

# Folder names
SRCDIR		:= src/
INCDIR		:= includes/
OBJDIR		:= bin/
LIBFTDIR	:= includes/libft/

MANDATORYF	:= mandatory/
BONUSF		:= bonus/

# The name of your executable in normal and bonus compilations
NAME		= push_swap
NAMEBONUS 	= $(NAME)

#operating system dependencies if any
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	LIBS := -lm -lbsd -lX11 -lXext
	MLX = mlx_linux/libmlx.a
	MINILIBX = mlx_linux
endif
ifeq ($(UNAME_S), Darwin)
	LIBS := -lz -framework OpenGL -framework AppKit
	MINILIBX = mlx_ios
	MLX = mlx_ios/libmlx.dylib
endif


# ============================= COMPILER OPTIONS ============================= #

# Compiler and compiling flags
CC		:= gcc
CFLAGS	:= -Wall -Werror -Wextra -O3

# Debug, use with`make DEBUG=1`
ifeq ($(DEBUG), 1)
CFLAGS	+= -g3 -fsanitize=address
endif

# Add include folder
CFLAGS	+= -I $(INCDIR)
# Linking stage flags
LDFLAGS =
LIBFT	= $(addprefix $(LIBFTDIR), "libft.a")


###▼▼▼<src-control-and-update>▼▼▼
# **************************************************************************** #
# **       Generated with https://github.com/irodrigo_42Mad/makefile        ** #
# **************************************************************************** #

# mandatory compilation file elements of application
SRCS = main ft_check_error\

HEADERS = push_swap lst_errors\

# bonus names are generated with srcs imput file names
SRCSBONUS = $(addsuffix "_bonus", $(SRCS))

HEADSBONUS = $(addsuffix "_bonus", $(HEADERS))
###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲


# =============================  INICIALIZATION  ===============================#

# String manipulation magic (complete each file name and path)
SRCEXT  	:= $(addsuffix .c, $(SRCS))
HDREXT		:= $(addsuffix .h, $(HEADERS))
SRCEXTB		:= $(addsuffix .c, $(SRCSBONUS))
HDREXTB		:= $(addsuffix .h, $(HEADSBONUS))
SRC			:= $(addprefix $(SRCDIR), $(addprefix $(MANDATORYF), $(SRCEXT)))
HDR			:= $(addprefix $(INCDIR), $(addprefix $(MANDATORYF), $(SRCEXT)))
SRCBONUS	:= $(addprefix $(SRCDIR), $(addprefix $(BONUSF), $(SRCEXTB)))
HDRBONUS	:= $(addprefix $(SRCDIR), $(addprefix $(BONUSF), $(HDREXTB)))

# object directory creation
OBJ			:= $(SRC:.c=.o)
OBJS		:= $(addprefix $(OBJDIR), $(notdir $(OBJ)))

OBJBONUS	:= $(SRCBONUS:.c=.o)
OBJSBONUS	:= $(addprefix $(OBJDIR), $(notdir $(OBJBONUS)))

# Colors
GR	= \033[32;1m
RE	= \033[31;1m
YE	= \033[33;1m
CY	= \033[36;1m
RC	= \033[0m

# Implicit rules
VPATH := $(SRCDIR) $(OBJDIR) $(shell find $(SRCDIR) -type d)

# ================================== RULES =================================== #
all : $(NAME)


#extern libraries








# Compiling
$(OBJDIR)%.o : %.c
	@clear
	@mkdir -p $(OBJDIR)
	@printf "$(GR)+$(RC)"
	$(CC) $(CFLAGS) -c $(OBJS) -o $(NAME)
	#@$(CC) $(CFLAGS) -c $< -o $@

# Linking


$(NAME)	: $(SRC) $(HEADERS) $(OBJS)
	@clear
	@printf "\n$(GR)=== Compiled [$(CC) $(CFLAGS)] ===\n--- $(SRC)$(RC)\n"
	@$(CC) $(CFLAGS) $(OBJS) $(HDR) $(LDFLAGS) -o $(NAME)
	@printf "$(YE)&&& Linked [$(CC) $(LDFLAGS)] &&&\n--- $(NAME)$(RC)\n"

printing :
	@printf "\n SRCEXT [$(SRC)]"
	@printf "\n HDREXT [$(HDR)]"
	@printf "\n"
	@printf "\n SRCEXTBONUS [$(SRCBONUS)]"
	@printf "\n SRCEXTBONUS [$(HDRBONUS)]"
	@printf "\n"
	@printf "\n OBJ [$(OBJS)]"
	@printf "\n OBJBONUS [$(OBJSBONUS)]"
	@printf "\n"
	@printf "\n LIBFT $(LIBFT)"

bonus:




# Cleaning
clean :
	@clear
	@echo "$(RE)--- Removing $(OBJDIR)$(RC)"
	@rm -rf $(OBJDIR)

fclean : clean
	@echo "$(RE)--- Removing $(NAME)$(RC)"
	@rm -f $(NAME)

normi:
	@clear
	norminette $(SRC) $(HDR)

normi_bonus:
	@clear
	norminette $(SRCBONUS) $(HDRBONUS)

# Special rule to force to remake everything
re : fclean all

# This runs the program
run : $(NAME)
	@echo "$(CY)>>> Running $(NAME)$(RC)"
	./$(NAME)

# This specifies the rules that does not correspond to any filename
.PHONY	= all run clean fclean normi re
