{include file='header.tpl'}

  <table class="table table-striped">
    <thead>
      <tr>
        <th>Id</th>
        <th>From</th>
        <th>To</th>
        <th>Start</th>
        <th>End</th>
      </tr>
    </thead>
    <tbody>
	{foreach from=$journeys key=id item=journey}
	  <tr>
        <td>{$id}</td>
        <td>{$journey.startLocation}</td>
        <td>{$journey.endLocation}</td>
        <td>{$journey.start}</td>
        <td>{$journey.end}</td>
      </tr>
	{/foreach}
    </tbody>
  </table>
  
{include file='footer.tpl'}