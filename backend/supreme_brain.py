def process(self, text):
    # অটোমেটিক প্রায়োরিটি লার্নিং
    freq_tool = self.memory.get_most_used_tool()
    if freq_tool and freq_tool in self.tools:
        # আগের সেরা টুলকেই প্রাধান্য দাও
        return self.tools[freq_tool].execute('auto', prompt=text)
    # বাকি আগের মতো...
