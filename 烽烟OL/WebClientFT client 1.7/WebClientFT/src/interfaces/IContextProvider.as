/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */


package interfaces
{
	import org.robotlegs.core.IContext;
	
	/**
	 * 获取模块Context
	 * @author Linus
	 * 
	 */	
	public interface IContextProvider
	{
		/**
		 * 获取模块级Context 
		 * @return 
		 * 
		 */		
		function getContext():IContext;
	}
}