require ["fileinto"];
# rule:[Spam]
if anyof (header :contains "X-Spam-Flag" "YES", header :contains "X-Spam-Status" "Yes")
{
	fileinto "Spam";
}
