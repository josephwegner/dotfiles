# vim:fileencoding=utf-8:noet
from __future__ import (unicode_literals, division, absolute_import, print_function)

from powerline.theme import requires_segment_info
from powerline.segments import with_docstring
from powerline.segments.common.env import CwdSegment
from powerline.lib.unicode import out_u

@requires_segment_info
def last_pipe_status(pl, segment_info):
	'''Return last pipe status.

	Highlight groups used: ``exit_fail``, ``exit_success``
	'''
	last_pipe_status = (
		segment_info['args'].last_pipe_status
		or (segment_info['args'].last_exit_code,)
	)
	if any(last_pipe_status):
		return [
			{
				'contents': str(status),
				'highlight_groups': ['exit_fail' if status else 'exit_success'],
				'draw_inner_divider': True
			}
			for status in last_pipe_status
		]
	else:
		return [
			{
				'contents': str("✓"),
				'highlight_groups': ['exit_success'],
				'draw_inner_divider': True
			}
		]
