import json

def string_to_json(input_string):
    lines = input_string.strip().split('\n')
    data = {}
    for line in lines:
        key, value = line.split(' : ')
        data[key.strip()] = value.strip()
    return json.dumps(data)

def json_to_string(json_string):
    data = json.loads(json_string)
    lines = [f"{key} : {value}" for key, value in data.items()]
    return '\n'.join(lines)

# Example usage:
#input_string = """key1 : value 1
#key2 : value 2
#key3 : value 3
#key4 : value 4"""

#json_string = string_to_json(input_string)
#print(json_string)

#output_string = json_to_string(json_string)
#print(output_string)

import google.generativeai as genai

def llm_response(llm_input):
    try:
        # Configure the API key
        genai.configure(api_key='AIzaSyCRqsKLp8KsfmgHOlIAHqqDIB9b0Xpscdo')  # Replace with actual API key
        
        # Initialize the model
        model = genai.GenerativeModel('gemini-pro')  # Use gemini-pro model
        
        # Construct the prompt
        prompt = f"""
        **Event Details:**
        {llm_input['event_details']}

        **Sessions:**
        {llm_input['sessions']}

        **Venue Details:**
        {llm_input['venue_details']}

        **Customized Details:**
        {llm_input['customized_details']}

        **Previous Conversation:**
        {llm_input['chat_history']}

        **User Query:**
        {llm_input['new_message_to_response']}
        """

        # Generate response
        response = model.generate_content(
            prompt,
            generation_config={
                'temperature': 0.7,
                'max_output_tokens': 256,
            }
        )

        return response.text

    except Exception as e:
        return f"Error generating response: {str(e)}"