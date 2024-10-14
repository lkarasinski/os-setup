package main

import (
	"fmt"
	"os"
	"os/exec"
	"runtime"

	"github.com/charmbracelet/huh"
	"github.com/charmbracelet/lipgloss"
)

type SetupOption struct {
	Name        string
	Description string
	Selected    bool
}

func (so SetupOption) String() string {
	return fmt.Sprintf("%s: %s", so.Name, so.Description)
}

var (
	titleStyle = lipgloss.NewStyle().
			Bold(true).
			Background(lipgloss.Color("#082f49")).
			Foreground(lipgloss.Color("#bae6fd")).
			MarginLeft(2).
			MarginTop(1).
			PaddingTop(1).
			PaddingRight(1).
			PaddingBottom(1).
			PaddingLeft(1).
			MarginBottom(1)

	alertStyle = lipgloss.NewStyle().
			Bold(false).
			MarginLeft(1).
			MarginTop(1).
			MarginBottom(1).
			Foreground(lipgloss.Color("#bae6fd"))
)

func clearConsole() {
	cmd := exec.Command("clear")
	cmd.Stdout = os.Stdout
	err := cmd.Run()
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}
}

func main() {
	if runtime.GOOS != "linux" {
		fmt.Print("OS not supported")
		os.Exit(1)
	}

	clearConsole()

	fmt.Println(titleStyle.Render("Ubuntu LXC Setup"))

	options := []SetupOption{
		{Name: "Base Setup", Description: "Required system updates and Ansible installation", Selected: true},
	}

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewMultiSelect[SetupOption]().
				Title("Choose setup options").
				Options(huh.NewOptions(options...)...).
				Value(&options).
				Validate(func(selected []SetupOption) error {
					for _, option := range selected {
						if option.Name == "Base Setup" {
							return nil
						}
					}
					return fmt.Errorf("base setup is required")
				}),
		),
	)

	err := form.Run()
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	fmt.Println(alertStyle.Render("\nSetup Summary:"))
	for _, option := range options {
		fmt.Printf("%s: %v\n", option.Name, option.Selected)
		if option.Selected {
			runSetup(option.Name)
		}
	}

	fmt.Println(alertStyle.Render("Setup complete!"))
}

func runSetup(optionName string) {
	switch optionName {
	case "Base Setup":
		setupBase()
	}
}

func setupBase() {
	fmt.Println(alertStyle.Render("Performing base setup..."))
	runCommand("apt", "update")
	runCommand("apt", "upgrade", "-y")
	runCommand("apt", "install", "-y", "curl", "git", "software-properties-common")
	runCommand("apt-add-repository", "--yes", "--update", "ppa:ansible/ansible")
	runCommand("apt", "install", "-y", "ansible")

	runCommand("rm", "-rf", "/tmp/os-setup")
	runCommand("git", "clone", "https://github.com/lkarasinski/os-setup.git", "/tmp/os-setup")
	runCommand("ansible-playbook", "/tmp/os-setup/playbooks/system_setup.yml")
}

func runCommand(name string, args ...string) {
	cmd := exec.Command(name, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		fmt.Printf("Error running command %s: %v\n", name, err)
		os.Exit(1)
	}
}
