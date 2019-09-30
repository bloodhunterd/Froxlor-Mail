require ["fileinto"];
# rule:[Spam]
if header :is "X-Spam-Flag" "YES"
{
	fileinto "Spam";
}
