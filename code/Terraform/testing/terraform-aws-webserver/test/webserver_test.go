package test

import (
	"fmt"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
)

func TestTerraformWebserverExample(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../Examples/webserver",
		Vars: map[string]interface{}{
			"region":     "us-west-2",
			"servername": "testwebserver",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	publicIp := terraform.Output(t, terraformOptions, "public_ip")

	url := fmt.Sprintf("http://%s:8080", publicIp)

	http_helper.HttpGetWithRetry(t, url, nil, 200, "I made a Terraform Module!", 30, 10*time.Second)

	defer terraform.Destroy(t, terraformOptions)

}
