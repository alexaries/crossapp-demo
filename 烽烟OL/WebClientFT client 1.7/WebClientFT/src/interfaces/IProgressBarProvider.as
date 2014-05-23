package interfaces
{
	import loader.ProgressBarControl;

	public interface IProgressBarProvider
	{
		function getProgressBarInstance():ProgressBarControl;
	}
}