using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

public class DataReader
{
	public List<string> ReadFile(string path)
	{
		if (!File.Exists(path))
		{
			return null;
		}

		var starDataList = new List<string>();
		using (var reader = new StreamReader(File.Open(path, FileMode.Open)))
		{
			while (reader.Peek() >= 0)
			{
				starDataList.Add(reader.ReadLine());
			}
		}
		//return starDataList;


		//using (var memoryStream = new MemoryStream(message))
		using (var streamReader = new StreamReader(File.Open(path, FileMode.Open)))
		{

			bool shouldParseHeader = true;
			string line;

			while ((line = streamReader.ReadLine()) != null)
			{
				if (shouldParseHeader)
				{
					ParseFrameHeader(line);

					// headers are separated from the body by an empty line
					shouldParseHeader = !string.IsNullOrEmpty(line);
				}
				else if (ParseFrameBody(messageBody, line))
				{
					// stop reading the body if reached the final of it
					break;
				}
			}
		}

		return null;
	}


	private void ParseFrameHeader(string messageLine)
	{
		string headerKey;
		string headerValue;
		if (!TryParseMessageHeaders(messageLine, out headerKey, out headerValue))
		{
			return;
		}

		if (!Headers.ContainsKey(headerKey))
		{
			this[headerKey] = headerValue;
		}
	}

	/// <returns>true if is the end of the message frame</returns>
	private bool ParseFrameBody(StringBuilder builder, string messageLine)
	{
		// check if this is the final line ending with an \0
		if (messageLine.Length > 0 && messageLine[messageLine.Length - 1] == '\0')
		{
			builder.Append(messageLine.Substring(0, messageLine.Length - 1));
			return true;
		}

		builder.AppendLine(messageLine);
		return false;
	}

	private bool TryParseMessageHeaders(string content, out string headerKey, out string headerValue)
	{
		int headerSeparationIndex = content.IndexOf(':');

		if (headerSeparationIndex > -1)
		{
		headerKey = content.Substring(0, headerSeparationIndex);
		headerValue = content.Substring(headerSeparationIndex + 1);
		return true;
		}

		headerValue = headerKey = null;
		return false;
	}
}


