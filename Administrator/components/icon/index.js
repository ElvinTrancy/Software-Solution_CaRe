
// option 1

const icons = {
  app: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
          <path d="M11 17a1 1 0 001.447.894l4-2A1 1 0 0017 15V9.236a1 1 0 00-1.447-.894l-4 2a1 1 0 00-.553.894V17zM15.211 6.276a1 1 0 000-1.788l-4.764-2.382a1 1 0 00-.894 0L4.789 4.488a1 1 0 000 1.788l4.764 2.382a1 1 0 00.894 0l4.764-2.382zM4.447 8.342A1 1 0 003 9.236V15a1 1 0 00.553.894l4 2A1 1 0 009 17v-5.764a1 1 0 00-.553-.894l-4-2z"></path>
        </svg>`,
  dashboard: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
              </svg>`,
  search: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
             <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
           </svg>`,
  insights: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
             </svg>`,
  docs: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2"></path>
         </svg>`,
  products: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
             </svg>`,
  settings: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"></path>
             </svg>`,
  messages: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path>
             </svg>`,
  account: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>`,
  arrow: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 1024 1024" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="32"  d="M830.24 340.688l11.328 11.312a16 16 0 0 1 0 22.624L530.448 685.76a16 16 0 0 1-22.64 0L196.688 374.624a16 16 0 0 1 0-22.624l11.312-11.312a16 16 0 0 1 22.624 0l288.496 288.496 288.512-288.496a16 16 0 0 1 22.624 0z"/>
          </svg>`
};


document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll('[data-icon]').forEach(el => {
      const iconName = el.getAttribute('data-icon');
      if (icons[iconName]) {
          el.innerHTML = icons[iconName];
      }
  });
});

// option 2

window._iconfont_svg_string_ = `<svg>
    <symbol id="icon-arrow" viewBox="0 0 24 24">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M13.5858 12.0127L9.29289 7.7198C8.90237 7.32928 8.90237 6.69611 9.29289 6.30559C9.68342 5.91506 10.3166 5.91506 10.7071 6.30559L15.7071 11.3056C16.0976 11.6961 16.0976 12.3293 15.7071 12.7198L10.7071 17.7198C10.3166 18.1103 9.68342 18.1103 9.29289 17.7198C8.90237 17.3293 8.90237 16.6961 9.29289 16.3056L13.5858 12.0127Z"/>
    </symbol>
    <symbol id="icon-patient" viewBox="0 0 1024 1024">
        <path d="M913 85.6 696.8 85.6c-31.6 0-57.4 25.6-57.4 57.2l0 398.8c0 15.8 0 23.2 114.4 86.4l0 112.8c0 8.8 7.2 16 16 16l8.2 0 0 140.4-68.4 0-37.2 0c13-21.2 20.2-50.8 20.2-92.2 0-137.6-80.4-250.8-183-263-0.8 48.2-122.2 147-122.2 147S266 590 265.2 542c-102.6 12.2-183 125.4-183 263 0 145.8 90.2 145.6 201.4 145.6l196.8 0 10.8 0 205.2 0 13.2 0 95 0c14.8 0 26.8-12 26.8-26.6l0-167 8.2 0c8.8 0 16-7.2 16-16l0-112.8C970 564.6 970 557.8 970 542L970 142.8C970.4 111.2 944.6 85.6 913 85.6zM917 529.6c-15 10.2-49.6 30.4-86.4 51.2l-51.6 0c-36.8-20.6-71.4-40.8-86.2-51l0-66.2c23-8 68.4-19.4 97 3.2 25 19.8 54.8 30.4 85.2 30.4 5 0 9.8-0.2 14.8-0.8 9.6-1 18.8-3.2 27.2-6.4L917 529.6zM917 183.8l-150 0c-12.8 0-23.2 10.4-23.2 23 0 12.6 10.2 23.2 23 23.2l150 0 0 27.2L828 257.2c-12.8 0-23.2 10.4-23.2 23 0 12.6 10.4 23 23.2 23l88.8 0 0 27.2-150 0c-12.8 0-23.2 10.4-23.2 23 0 12.8 10.4 23 23.2 23l150 0 0 68.6c-8 5.8-19.4 9.8-31.6 11.2-14.4 1.6-42.6 1-70.4-21.2-38.2-30.6-89.4-23.4-122-14L692.8 142.8c0-2.2 1.8-4 4-4l216.2 0c2.2 0 4 1.8 4 4L917 183.8z" />
        <path d="M231.8 349.2c0.2 1.4 0.2 3 0.4 4.4 10 112.4 75.8 199.4 155.4 199.4 80.8 0 147.2-89.2 155.8-203.8 1.2-8.2 1.8-16.6 1.8-25.2s-0.6-17-1.8-25.2c-11.4-79.8-76.8-140.8-155.8-140.8s-144.4 61-155.8 140.8c-1.2 8.2-1.8 16.6-1.8 25.2 0 3.4 0.2 7 0.4 10.4C230.6 339.2 231.2 344.2 231.8 349.2z"/>
    </symbol>
    <symbol id='icon-home' viewBox='0 0 24 25'>
      <path opacity="0.4" d="M16.0756 2.0127H19.4616C20.8639 2.0127 22.0001 3.15855 22.0001 4.57266V7.98722C22.0001 9.40133 20.8639 10.5472 19.4616 10.5472H16.0756C14.6734 10.5472 13.5371 9.40133 13.5371 7.98722V4.57266C13.5371 3.15855 14.6734 2.0127 16.0756 2.0127Z"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M4.53852 2.0127H7.92449C9.32676 2.0127 10.463 3.15855 10.463 4.57266V7.98722C10.463 9.40133 9.32676 10.5472 7.92449 10.5472H4.53852C3.13626 10.5472 2 9.40133 2 7.98722V4.57266C2 3.15855 3.13626 2.0127 4.53852 2.0127ZM4.53852 13.4782H7.92449C9.32676 13.4782 10.463 14.6241 10.463 16.0382V19.4527C10.463 20.8659 9.32676 22.0127 7.92449 22.0127H4.53852C3.13626 22.0127 2 20.8659 2 19.4527V16.0382C2 14.6241 3.13626 13.4782 4.53852 13.4782ZM19.4615 13.4782H16.0755C14.6732 13.4782 13.537 14.6241 13.537 16.0382V19.4527C13.537 20.8659 14.6732 22.0127 16.0755 22.0127H19.4615C20.8637 22.0127 22 20.8659 22 19.4527V16.0382C22 14.6241 20.8637 13.4782 19.4615 13.4782Z" />
    </symbol>
    <symbol id="icon-game" viewBox = '0 0 24 25'>
      <path opacity="0.4" d="M13.3051 5.89512V6.07817C12.8144 6.06853 12.3237 6.06853 11.8331 6.06853V5.90476C11.8331 5.24002 11.2737 4.70053 10.6064 4.70053H9.63482C8.52589 4.70053 7.62305 3.81422 7.62305 2.73523C7.62305 2.34025 7.95671 2.0127 8.35906 2.0127C8.77123 2.0127 9.09508 2.34025 9.09508 2.73523C9.09508 3.02425 9.34042 3.25546 9.63482 3.25546H10.6064C12.0882 3.26509 13.2953 4.45005 13.3051 5.89512Z"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M15.164 6.095C15.4791 6.09932 15.7949 6.10365 16.1119 6.10689C19.5172 6.10689 22 8.53462 22 11.8872V16.1935C22 19.5461 19.5172 21.9738 16.1119 21.9738C14.7478 22.0027 13.3837 22.0123 12.0098 22.0123C10.6359 22.0123 9.25221 22.0027 7.88813 21.9738C4.48283 21.9738 2 19.5461 2 16.1935V11.8872C2 8.53462 4.48283 6.10689 7.89794 6.10689C9.18351 6.08763 10.4985 6.06836 11.8332 6.06836C12.3238 6.06836 12.8145 6.06836 13.3052 6.07799C13.9238 6.07799 14.5425 6.08648 15.164 6.095ZM10.8518 14.7581H9.82139V15.7792C9.82139 16.1742 9.48773 16.5018 9.08538 16.5018C8.67321 16.5018 8.34936 16.1742 8.34936 15.7792V14.7581H7.30913C6.90677 14.7581 6.57311 14.4401 6.57311 14.0355C6.57311 13.6405 6.90677 13.313 7.30913 13.313H8.34936V12.3014C8.34936 11.9065 8.67321 11.5789 9.08538 11.5789C9.48773 11.5789 9.82139 11.9065 9.82139 12.3014V13.313H10.8518C11.2542 13.313 11.5878 13.6405 11.5878 14.0355C11.5878 14.4401 11.2542 14.7581 10.8518 14.7581ZM15.0226 13.1299H15.1207C15.5231 13.1299 15.8567 12.812 15.8567 12.4074C15.8567 12.0124 15.5231 11.6849 15.1207 11.6849H15.0226C14.6104 11.6849 14.2866 12.0124 14.2866 12.4074C14.2866 12.812 14.6104 13.1299 15.0226 13.1299ZM16.7007 16.444H16.7988C17.2012 16.444 17.5348 16.1261 17.5348 15.7214C17.5348 15.3265 17.2012 14.9989 16.7988 14.9989H16.7007C16.2885 14.9989 15.9647 15.3265 15.9647 15.7214C15.9647 16.1261 16.2885 16.444 16.7007 16.444Z"/>
    </symbol>
    <symbol id="icon-patient" viewBox="0 0 24 25">
      <path opacity="0.4" d="M21.25 13.4891C20.429 13.4891 19.761 12.8272 19.761 12.0137C19.761 11.1992 20.429 10.5373 21.25 10.5373C21.449 10.5373 21.64 10.459 21.78 10.3203C21.921 10.1806 22 9.99134 22 9.79416L21.999 7.11685C21.999 4.85372 20.14 3.0127 17.856 3.0127H6.144C3.86 3.0127 2.001 4.85372 2.001 7.11685L2 9.88036C2 10.0775 2.079 10.2668 2.22 10.4065C2.36 10.5452 2.551 10.6235 2.75 10.6235C3.599 10.6235 4.239 11.221 4.239 12.0137C4.239 12.8272 3.571 13.4891 2.75 13.4891C2.336 13.4891 2 13.822 2 14.2322V16.9076C2 19.1707 3.858 21.0127 6.143 21.0127H17.857C20.142 21.0127 22 19.1707 22 16.9076V14.2322C22 13.822 21.664 13.4891 21.25 13.4891Z"/>
      <path d="M15.4308 11.6009L14.2518 12.7489L14.5308 14.3719C14.5788 14.6529 14.4658 14.9299 14.2348 15.0959C14.0058 15.2639 13.7068 15.2849 13.4548 15.1509L11.9998 14.3859L10.5418 15.1519C10.4338 15.2089 10.3158 15.2389 10.1988 15.2389C10.0458 15.2389 9.89483 15.1909 9.76483 15.0969C9.53483 14.9299 9.42183 14.6529 9.46983 14.3719L9.74783 12.7489L8.56883 11.6009C8.36483 11.4029 8.29383 11.1119 8.38183 10.8409C8.47083 10.5709 8.70083 10.3789 8.98183 10.3389L10.6078 10.1019L11.3368 8.62489C11.4638 8.37089 11.7178 8.21289 11.9998 8.21289H12.0018C12.2848 8.21389 12.5388 8.37189 12.6638 8.62589L13.3928 10.1019L15.0218 10.3399C15.2998 10.3789 15.5298 10.5709 15.6178 10.8409C15.7068 11.1119 15.6358 11.4029 15.4308 11.6009Z"/>
    </symbol>
    <symbol id = 'icon-authentication' viewBox = '0 0 24 25'>
      <path opacity="0.4" d="M12.0865 22.0127C11.9627 22.0127 11.8388 21.9843 11.7271 21.9264L8.12599 20.0623C7.10415 19.5328 6.30481 18.9385 5.68063 18.2463C4.31449 16.7322 3.5544 14.7887 3.54232 12.7726L3.50004 6.13696C3.495 5.37112 3.98931 4.68372 4.72826 4.42485L11.3405 2.11948C11.7331 1.97926 12.1711 1.9773 12.5707 2.11262L19.2081 4.33954C19.9511 4.58763 20.4535 5.27012 20.4575 6.03498L20.4998 12.6755C20.5129 14.6887 19.779 16.64 18.434 18.1707C17.8168 18.8729 17.0245 19.4759 16.0128 20.0152L12.4439 21.9215C12.3331 21.9813 12.2103 22.0117 12.0865 22.0127Z" fill="#8A92A6"/>
      <path d="M11.3189 14.3336C11.1256 14.3346 10.9323 14.265 10.7833 14.1218L8.86646 12.2783C8.57048 11.992 8.56746 11.5272 8.86042 11.2389C9.15338 10.9496 9.63158 10.9467 9.92857 11.232L11.3078 12.5578L14.6753 9.23749C14.9693 8.94821 15.4475 8.94527 15.7435 9.23062C16.0405 9.51695 16.0435 9.98273 15.7505 10.27L11.8514 14.1149C11.7045 14.2601 11.5122 14.3326 11.3189 14.3336Z" fill="#8A92A6"/>
    <symbol id="icon-group" viewBox="0 0 1024 1024">
      <path d="M506.084374 534.992115h-90.244604c-164.359367 0-297.523568 133.164201-297.523569 308.452374v21.061986c0 24.325525 18.509353 44.065151 41.332029 44.065151h602.631367c22.822676 0 41.332029-19.739626 41.332029-44.065151v-21.061986c0-175.288173-133.164201-308.452374-297.527252-308.452374z m174.323108 203.142446c0 8.545612-4.232288 15.418935-9.341237 15.418935h-51.99931v44.153554c0 5.197353-6.784921 9.518043-15.15741 9.518044h-30.403223c-8.372489 0-15.161094-4.232288-15.161093-9.518044v-44.153554H508.206043c-5.201036 0-9.341237-6.873324-9.341237-15.422618v-30.845238c0-8.545612 4.228604-15.422619 9.341237-15.422618h50.142849V643.130935c0-5.204719 6.788604-9.521727 15.161094-9.521726h30.403223c8.372489 0 15.15741 4.228604 15.15741 9.518043v48.73577h51.999309c5.197353 0 9.341237 6.873324 9.341237 15.422618v30.845238z m210.277295-394.295252H694.330935a17.676892 17.676892 0 0 1-17.625323-17.625323v-26.439828A17.676892 17.676892 0 0 1 694.330935 282.152518h196.353842a17.680576 17.680576 0 0 1 17.625324 17.625324v26.439827a17.62164 17.62164 0 0 1-17.625324 17.625324z m-0.972432 144.531338h-141.00259a17.676892 17.676892 0 0 1-17.629007-17.625323v-26.436144a17.676892 17.676892 0 0 1 17.625324-17.629007h141.006273a17.680576 17.680576 0 0 1 17.629008 17.629007v26.436144a17.570072 17.570072 0 0 1-17.629008 17.625323z m2.210072 154.491396h-78.969554a17.676892 17.676892 0 0 1-17.625323-17.625324v-26.439827a17.676892 17.676892 0 0 1 17.625323-17.625324h78.965871a17.680576 17.680576 0 0 1 17.625324 17.625324v26.439827a17.680576 17.680576 0 0 1-17.625324 17.625324z"  ></path><path d="M253.948317 305.767137c0 103.040921 81.953151 186.57059 183.045525 186.57059 101.092374 0 183.045525-83.529669 183.045525-186.566907 0-103.040921-81.953151-186.574273-183.045525-186.574273-101.092374 0-183.045525 83.533353-183.045525 186.57059z"></path>
    </symbol>
    <symbol id="icon-schedule" viewBox="0 0 1024 1024">
      <path fill="currentColor" d="M192 85.333333C132.266667 85.333333 85.333333 134.4 85.333333 194.133333v633.6C85.333333 889.6 132.266667 938.666667 192 938.666667h640c59.733333 0 106.666667-49.066667 106.666667-108.8V194.133333C938.666667 134.4 891.733333 85.333333 832 85.333333m6.4 64c19.2 0 36.266667 17.066667 36.266667 38.4v125.866667H149.333333V187.733333C149.333333 166.4 166.4 149.333333 185.6 149.333333m652.8 725.333334H185.6c-19.2 0-36.266667-17.066667-36.266667-38.4V377.6h725.333334v460.8c0 19.2-17.066667 36.266667-36.266667 36.266667z" fill="currentColor" ></path><path fill="currentColor" d="M260.266667 556.8h74.666666c17.066667 0 34.133333-14.933333 32-34.133333v-4.266667c0-17.066667-14.933333-34.133333-34.133333-34.133333h-72.533333c-17.066667 0-34.133333 14.933333-34.133334 34.133333v4.266667c2.133333 19.2 14.933333 34.133333 34.133334 34.133333z" ></path><path d="M484.266667 556.8h72.533333c17.066667 0 34.133333-14.933333 34.133333-34.133333v-4.266667c0-17.066667-14.933333-34.133333-34.133333-34.133333h-72.533333c-17.066667 0-34.133333 14.933333-34.133334 34.133333v4.266667c0 19.2 14.933333 34.133333 34.133334 34.133333z" fill="currentColor" ></path><path d="M708.266667 556.8h72.533333c17.066667 0 34.133333-14.933333 34.133333-34.133333v-4.266667c0-17.066667-14.933333-34.133333-34.133333-34.133333h-72.533333c-17.066667 0-34.133333 14.933333-34.133334 34.133333v4.266667c0 19.2 12.8 34.133333 34.133334 34.133333zM260.266667 699.733333h74.666666c17.066667 0 34.133333-17.066667 32-34.133333V661.333333c0-17.066667-14.933333-34.133333-34.133333-34.133333h-72.533333c-17.066667 0-34.133333 14.933333-34.133334 34.133333v4.266667c2.133333 17.066667 14.933333 34.133333 34.133334 34.133333zM708.266667 699.733333h72.533333c17.066667 0 34.133333-17.066667 34.133333-34.133333V661.333333c0-17.066667-14.933333-34.133333-34.133333-34.133333h-72.533333c-17.066667 0-34.133333 14.933333-34.133334 34.133333v4.266667c0 17.066667 12.8 34.133333 34.133334 34.133333z" fill="currentColor" ></path><path d="M484.266667 699.733333h72.533333c17.066667 0 34.133333-17.066667 34.133333-34.133333V661.333333c0-17.066667-14.933333-34.133333-34.133333-34.133333h-72.533333c-17.066667 0-34.133333 14.933333-34.133334 34.133333v4.266667c0 17.066667 14.933333 34.133333 34.133334 34.133333z" fill="currentColor" ></path>
    </symbol>
    <symbol id="icon-arrow-up" viewBox = "0 0 20 21"><path d="M1.19045 18.784C0.820898 19.1944 0.854036 19.8267 1.26446 20.1963C1.67489 20.5658 2.30719 20.5327 2.67674 20.1223L1.19045 18.784ZM18.7763 1.80421C18.7474 1.25268 18.2768 0.829008 17.7253 0.857912L8.73763 1.32894C8.1861 1.35784 7.76243 1.82837 7.79134 2.3799C7.82024 2.93143 8.29077 3.3551 8.8423 3.32619L16.8313 2.90751L17.25 10.8965C17.2789 11.4481 17.7495 11.8717 18.301 11.8428C18.8525 11.8139 19.2762 11.3434 19.2473 10.7919L18.7763 1.80421ZM2.67674 20.1223L18.5208 2.52567L17.0345 1.18741L1.19045 18.784L2.67674 20.1223Z"/></symbol>
    <symbol id="icon-menu" viewBox = "0 0 1024 1024">
    <path d="M746.932 698.108" p-id="4360"/><path d="M925.731 288.698c-1.261-1.18-3.607-3.272-6.902-6.343-5.486-5.112-11.615-10.758-18.236-16.891-18.921-17.526-38.003-35.028-56.046-51.397-2.038-1.848-2.038-1.835-4.077-3.682-24.075-21.795-44.156-39.556-58.996-52.076-8.682-7.325-15.517-12.807-20.539-16.426-3.333-2.402-6.043-4.13-8.715-5.396-3.365-1.595-6.48-2.566-10.905-2.483C729.478 134.227 720 143.77 720 155.734l0 42.475 0 42.475 0 84.95L720 347l21.205 0L890 347l0 595L358.689 942C323.429 942 295 913.132 295 877.922L295 177l361.205 0c11.736 0 21.25-9.771 21.25-21.5s-9.514-21.5-21.25-21.5l-382.5 0L252 134l0 21.734L252 813l-52.421 0C166.646 813 140 786.928 140 754.678L140 72l566.286 0C739.29 72 766 98.154 766 130.404L766 134l40 0 0-3.596C806 76.596 761.271 33 706.286 33L119.958 33 100 33l0 19.506 0 702.172C100 808.463 144.642 852 199.579 852L252 852l0 25.922C252 936.612 299.979 984 358.689 984l552.515 0L932 984l0-21.237L932 325.635 932 304l0.433 0C932.432 299 930.196 292.878 925.731 288.698zM762 304l0-63.315L762 198.21l0-0.273c14 11.479 30.3 26.369 49.711 43.942 2.022 1.832 2.136 1.832 4.157 3.665 17.923 16.259 36.957 33.492 55.779 50.926 2.878 2.666 5.713 5.531 8.391 7.531L762 304.001z" p-id="4361"/><path d="M816.936 436 407.295 436c-10.996 0-19.91 8.727-19.91 19.5 0 10.77 8.914 19.5 19.91 19.5l409.641 0c11 0 19.914-8.73 19.914-19.5C836.85 444.727 827.936 436 816.936 436z"  p-id="4362"/><path d="M816.936 553 407.295 553c-10.996 0-19.91 8.727-19.91 19.5 0 10.774 8.914 19.5 19.91 19.5l409.641 0c11 0 19.914-8.726 19.914-19.5C836.85 561.727 827.936 553 816.936 553z" p-id="4363"/><path d="M816.936 689 407.295 689c-10.996 0-19.91 8.729-19.91 19.503 0 10.769 8.914 19.497 19.91 19.497l409.641 0c11 0 19.914-8.729 19.914-19.497C836.85 697.729 827.936 689 816.936 689z" p-id="4364"/>
    </symbol>
    <symbol id="icon-left" viewBox = "0 0 8 13">
    <path opacity="0.683896" fill-rule="evenodd" clip-rule="evenodd" d="M7.85822 1.46798L3.10048 5.90464L7.53714 10.6624L6.08913 12.0127L0.302186 5.80692L6.50793 0.0199741L7.85822 1.46798Z"/>
    </symbol>
    <symbol id="icon-announcement" viewBox = "0 0 24 24">
      <path d="M11.8251 15.2171H12.1748C14.0987 15.2171 15.731 13.985 16.3054 12.2764C16.3887 12.0276 16.1979 11.7713 15.9334 11.7713H14.8562C14.5133 11.7713 14.2362 11.4977 14.2362 11.16C14.2362 10.8213 14.5133 10.5467 14.8562 10.5467H15.9005C16.2463 10.5467 16.5263 10.2703 16.5263 9.92875C16.5263 9.58722 16.2463 9.31075 15.9005 9.31075H14.8562C14.5133 9.31075 14.2362 9.03619 14.2362 8.69849C14.2362 8.35984 14.5133 8.08528 14.8562 8.08528H15.9005C16.2463 8.08528 16.5263 7.8088 16.5263 7.46728C16.5263 7.12575 16.2463 6.84928 15.9005 6.84928H14.8562C14.5133 6.84928 14.2362 6.57472 14.2362 6.23606C14.2362 5.89837 14.5133 5.62381 14.8562 5.62381H15.9886C16.2483 5.62381 16.4343 5.3789 16.3645 5.13113C15.8501 3.32401 14.1694 2 12.1748 2H11.8251C9.42172 2 7.47363 3.92287 7.47363 6.29729V10.9198C7.47363 13.2933 9.42172 15.2171 11.8251 15.2171Z" fill="white"/>
      <path opacity="0.4" d="M19.5313 9.8252C18.9966 9.8252 18.5626 10.2528 18.5626 10.7818C18.5626 14.355 15.6186 17.2622 12.0005 17.2622C8.38136 17.2622 5.43743 14.355 5.43743 10.7818C5.43743 10.2528 5.00345 9.8252 4.46872 9.8252C3.93398 9.8252 3.5 10.2528 3.5 10.7818C3.5 15.0868 6.79945 18.6408 11.0318 19.1181V21.0429C11.0318 21.571 11.4648 21.9996 12.0005 21.9996C12.5352 21.9996 12.9692 21.571 12.9692 21.0429V19.1181C17.2006 18.6408 20.5 15.0868 20.5 10.7818C20.5 10.2528 20.066 9.8252 19.5313 9.8252Z" fill="white"/>
    </symbol>
    <symbol id="icon-ownership" viewBox="0 0 1024 1024"><path d="M710.615452 551.428893C778.856536 494.571982 824.39323 409.318593 824.39323 312.744988 824.329274 142.110299 682.218974 0 511.648242 0 341.077509 0 198.96721 142.110299 198.96721 312.681032c0 96.637562 45.472737 181.89095 113.713822 238.747861C147.73843 619.733933 28.396477 773.228405 5.692087 960.747486c-5.692087 28.460433 17.07626 56.920867 51.164824 62.548998h5.692087c28.396477 0 51.164824-22.768347 56.85691-51.164825C142.110299 773.164449 312.681032 625.362064 511.648242 625.362064c51.164824 0 102.329648 11.384173 147.802386 28.396477 28.460433 11.384173 62.548998 0 73.933171-28.396477 11.320217-28.460433 0-56.920867-22.768347-73.933171zM312.744988 312.744988C312.681032 204.659297 403.562551 113.713822 511.648242 113.713822c108.021735 0 198.96721 90.945475 198.96721 198.903254C710.615452 420.766723 619.733933 511.648242 511.648242 511.648242 403.626507 511.648242 312.681032 420.702767 312.681032 312.681032z m653.758541 540.044719H625.362064c-34.15252 0-56.920867-22.704391-56.920867-56.856911 0-34.088564 22.768347-56.792955 56.920867-56.792955h341.077509c34.088564 0 56.856911 22.704391 56.856911 56.792955 0 34.15252-22.768347 56.920867-56.856911 56.920867z m0-170.506777h-113.713822c-34.088564 0-56.856911-22.768347-56.856911-56.920866 0-34.088564 22.768347-56.792955 56.920867-56.792955h113.649866c34.088564 0 56.856911 22.704391 56.856911 56.856911 0 34.088564-22.768347 56.856911-56.856911 56.85691z m0 341.07751h-227.363688c-34.15252 0-56.920867-22.768347-56.920867-56.856911s22.768347-56.856911 56.920867-56.856911h227.363688c34.088564 0 56.856911 22.768347 56.856911 56.920867 0 34.024608-22.768347 56.792955-56.856911 56.792955z"></path></symbol>
    <symbol id="icon-training" viewBox="0 0 1024 1024">
    <path d="M297.718519 321.738272c24.019753 73.323457 92.28642 73.323457 116.306172 0 8.217284-4.424691 16.434568-16.434568 17.698766-26.548149 1.264198-10.745679 0.632099-25.283951-10.11358-25.28395-2.528395-34.133333-21.491358-63.209877-64.474075-63.209877-42.350617 0-63.841975 25.283951-66.37037 63.209877-10.745679 0-11.377778 14.538272-10.11358 25.28395 1.264198 10.11358 9.481481 22.123457 17.066667 26.548149z" ></path><path d="M453.846914 742.716049v-25.28395c28.444444 0 51.2-22.755556 51.2-51.2v-208.592593c0-36.661728-26.548148-68.266667-64.474074-76.48395l-27.180247-5.688889-57.520988 113.145679-57.520988-113.145679-27.180247 5.688889c-37.293827 7.585185-64.474074 39.822222-64.474074 76.48395v209.224692c0 27.812346 22.755556 51.2 51.2 51.2v25.28395l195.950618-0.632099z" ></path><path d="M851.437037 732.602469H546.765432c-13.274074 0-24.019753-10.745679-24.019753-24.019753s10.745679-24.019753 24.019753-24.019753h304.671605c65.106173 0 118.202469-52.464198 118.202469-117.57037V182.676543c0-64.474074-53.096296-116.938272-118.202469-116.938271H172.562963C107.45679 65.106173 54.992593 117.57037 54.992593 182.676543v384.31605c0 64.474074 53.096296 117.57037 118.202469 117.57037 13.274074 0 25.283951 10.745679 25.28395 24.019753s-10.11358 24.019753-23.387654 24.019753C80.908642 732.602469 6.320988 658.014815 6.320988 566.992593V182.676543C6.320988 91.022222 80.908642 17.066667 172.562963 17.066667h678.874074c91.654321 0 166.241975 74.587654 166.241975 165.609876v384.31605c0 91.022222-74.587654 165.609877-166.241975 165.609876z" ></path><path d="M225.659259 792.651852H119.466667c-51.2 0-92.918519 41.718519-92.918519 92.28642v121.995061h292.02963V884.938272c0-51.2-41.718519-92.28642-92.918519-92.28642zM562.567901 792.651852H456.375309c-51.2 0-92.918519 41.718519-92.918519 92.28642v121.995061h292.02963V884.938272c0-51.2-41.718519-92.28642-92.918519-92.28642zM899.476543 792.651852h-106.192592c-51.2 0-92.918519 41.718519-92.918519 92.28642v121.995061H992.395062V884.938272c0-51.2-41.718519-92.28642-92.918519-92.28642z"></path>
    </symbol>
    <symbol id="icon-profession" viewBox="0 0 1159 1024">
      <path d="M1067.885714 793.6c3.657143 0 7.314286 3.657143 14.628572 3.657143 21.942857 0 36.571429-18.285714 36.571428-43.885714v-266.971429c0-21.942857-18.285714-36.571429-36.571428-36.571429h-3.657143c-18.285714 3.657143-32.914286 18.285714-32.914286 40.228572v263.314286c-3.657143 18.285714 7.314286 32.914286 21.942857 40.228571zM1130.057143 921.6c-3.657143-25.6-10.971429-47.542857-18.285714-69.485714-3.657143-10.971429-10.971429-18.285714-14.628572-25.6-7.314286-7.314286-10.971429-7.314286-14.628571-7.314286-3.657143 0-10.971429 3.657143-14.628572 7.314286-7.314286 7.314286-10.971429 14.628571-14.628571 21.942857-10.971429 21.942857-18.285714 47.542857-21.942857 73.142857-3.657143 25.6 10.971429 51.2 36.571428 58.514286 3.657143 0 3.657143 0 7.314286 3.657143h18.285714c18.285714-7.314286 29.257143-21.942857 36.571429-43.885715v-18.285714z"></path>
      <path d="M1152 270.628571v-7.314285V256c-10.971429-51.2-40.228571-80.457143-84.114286-91.428571-91.428571-25.6-186.514286-47.542857-277.942857-73.142858l-18.285714-3.657142c-54.857143-14.628571-113.371429-29.257143-171.885714-43.885715-3.657143 0-3.657143 0-7.314286-3.657143h-29.257143c-10.971429 3.657143-21.942857 3.657143-32.914286 7.314286-10.971429 3.657143-25.6 7.314286-36.571428 10.971429-29.257143 3.657143-102.4 21.942857-102.4 21.942857C288.914286 109.714286 182.857143 135.314286 80.457143 164.571429c-43.885714 10.971429-76.8 51.2-80.457143 102.4V299.885714C7.314286 351.085714 40.228571 391.314286 84.114286 402.285714c29.257143 7.314286 62.171429 14.628571 87.771428 21.942857 3.657143 0 7.314286 0 7.314286 10.971429V768c0 47.542857 14.628571 84.114286 47.542857 117.028571 25.6 25.6 54.857143 43.885714 98.742857 58.514286 69.485714 25.6 146.285714 32.914286 201.142857 36.571429h54.857143c36.571429 0 69.485714 0 106.057143-3.657143 51.2-3.657143 95.085714-14.628571 135.314286-29.257143 43.885714-14.628571 76.8-32.914286 102.4-58.514286 36.571429-32.914286 54.857143-73.142857 54.857143-124.342857V555.885714v-120.685714c0-10.971429 3.657143-10.971429 7.314285-10.971429l87.771429-21.942857c43.885714-10.971429 69.485714-43.885714 80.457143-91.428571 0-3.657143 0-7.314286 3.657143-10.971429v-3.657143l-7.314286-25.6z m-252.342857 501.028572c0 10.971429-3.657143 21.942857-10.971429 32.914286-7.314286 10.971429-21.942857 25.6-36.571428 32.914285-32.914286 21.942857-65.828571 36.571429-113.371429 47.542857-51.2 10.971429-102.4 18.285714-160.914286 18.285715-18.285714 0-40.228571 0-62.171428-3.657143-58.514286-3.657143-106.057143-14.628571-149.942857-29.257143-32.914286-10.971429-58.514286-25.6-80.457143-40.228571-7.314286-3.657143-10.971429-10.971429-14.628572-14.628572-14.628571-14.628571-18.285714-29.257143-18.285714-47.542857v-219.428571V449.828571h3.657143c7.314286 0 10.971429 3.657143 18.285714 3.657143 95.085714 25.6 197.485714 51.2 277.942857 73.142857h3.657143c7.314286 0 14.628571 3.657143 21.942857 3.657143 14.628571 0 29.257143-3.657143 40.228572-7.314285 54.857143-14.628571 109.714286-29.257143 157.257143-40.228572h3.657143l120.685714-32.914286h3.657143v113.371429c-3.657143 62.171429-3.657143 135.314286-3.657143 208.457143zM1075.2 292.571429c-3.657143 18.285714-14.628571 25.6-29.257143 29.257142-18.285714 7.314286-106.057143 29.257143-106.057143 29.257143l-164.571428 43.885715-10.971429 3.657142c-62.171429 14.628571-120.685714 32.914286-179.2 47.542858h-7.314286-3.657142c-10.971429-3.657143-21.942857-7.314286-36.571429-10.971429-87.771429-21.942857-179.2-47.542857-266.971429-69.485714L102.4 325.485714C80.457143 318.171429 69.485714 303.542857 69.485714 281.6s10.971429-36.571429 29.257143-40.228571C182.857143 219.428571 266.971429 197.485714 347.428571 175.542857L391.314286 164.571429c54.857143-14.628571 113.371429-29.257143 171.885714-43.885715h21.942857c73.142857 18.285714 146.285714 40.228571 219.428572 58.514286 0 0 190.171429 51.2 241.371428 62.171429 10.971429 3.657143 21.942857 10.971429 25.6 21.942857 7.314286 7.314286 7.314286 18.285714 3.657143 29.257143z">
      </path>
    </symbol>
    <symbol id="icon-certification" viewBox="0 0 1024 1024">
      <path d="M478.058667 40.725333a48 48 0 0 1 67.882666 0l113.984 113.984h161.354667a48 48 0 0 1 47.946667 45.749334l0.053333 2.261333V364.053333l113.994667 113.994667a48 48 0 0 1 1.706666 66.090667l-1.706666 1.792-113.994667 113.984v161.354666a48 48 0 0 1-45.738667 47.946667l-2.261333 0.053333H659.925333L545.941333 983.274667a48 48 0 0 1-66.090666 1.706666l-1.792-1.706666-113.994667-113.994667H202.72a48 48 0 0 1-47.946667-45.738667l-0.053333-2.261333-0.010667-161.354667L40.725333 545.941333a48 48 0 0 1-1.706666-66.090666l1.706666-1.792 113.984-113.994667V202.72a48 48 0 0 1 45.749334-47.946667l2.261333-0.053333 161.344-0.010667zM512 142.538667l-94.112 94.122666a48 48 0 0 1-33.941333 14.058667l-133.237334-0.010667v133.237334a48 48 0 0 1-12.298666 32.106666l-1.749334 1.834667L142.538667 512l94.122666 94.112a48 48 0 0 1 13.984 31.402667l0.074667 2.538666-0.010667 133.226667h133.237334a48 48 0 0 1 32.106666 12.309333l1.834667 1.749334L512 881.450667l94.112-94.112a48 48 0 0 1 31.402667-13.984l2.538666-0.074667h133.226667v-133.226667a48 48 0 0 1 12.309333-32.106666l1.749334-1.834667L881.450667 512l-94.112-94.112a48 48 0 0 1-13.984-31.402667l-0.074667-2.538666V250.709333h-133.226667a48 48 0 0 1-32.106666-12.298666l-1.834667-1.749334L512 142.538667z m136.725333 231.146666l67.882667 67.872L511.253333 646.912a48 48 0 0 1-66.090666 1.706667l-1.792-1.706667L307.392 510.933333l67.882667-67.882666 102.037333 102.037333 171.413333-171.413333z" ></path>
    </symbol>
    <symbol id="icon-training" viewBox="0 0 30 30">
      <path d="M25 26.25V19C25 18.1716 24.3284 17.5 23.5 17.5H6.5C5.67157 17.5 5 18.1716 5 19V26.25" stroke-width="2"/>
      <rect x="10" y="3.75" width="10" height="10" rx="1.5" stroke-width="2"/>
      <path d="M10 17.5V21C10 21.8284 10.6716 22.5 11.5 22.5H18.5C19.3284 22.5 20 21.8284 20 21V17.5" stroke-width="2"/>
      <path d="M10 7.5H20" stroke-width="2"/>
      <path d="M15 22.5V26.25" stroke-width="2"/>
    </symbol>
    <symbol id='icon-show' viewBox="0 0 1403 1024"><path fill="currentColor" d="M455.890411 564.60274c0-10.520548-3.506849-21.041096-3.506849-35.068493 0-136.767123 108.712329-245.479452 245.479452-245.479452 14.027397 0 28.054795 0 38.575342 3.506849l147.287671-143.780822c-59.616438-14.027397-119.232877-21.041096-182.356164-21.041096C403.287671 122.739726 143.780822 287.561644 0 526.027397c59.616438 98.191781 140.273973 185.863014 238.465753 252.493151L455.890411 564.60274zM1132.712329 252.493151l-203.39726 196.383562c10.520548 24.547945 14.027397 52.60274 14.027397 80.657534 0 136.767123-108.712329 245.479452-245.479452 245.479452-31.561644 0-59.616438-7.013699-87.671233-17.534247l-136.767123 136.767123c73.643836 21.041096 147.287671 35.068493 227.945205 35.068493 298.082192 0 557.589041-164.821918 701.369863-403.287671C1336.109589 413.808219 1241.424658 319.123288 1132.712329 252.493151zM785.534247 592.657534l-28.054795 24.547945C768 610.191781 775.013699 603.178082 785.534247 592.657534zM1125.69863 14.027397 171.835616 946.849315l77.150685 77.150685L1202.849315 87.671233 1125.69863 14.027397z"/></symbol>
    <symbol id="icon-hide" viewBox="0 0 1396 1024"><path fill="currentColor" d="M1344.093091 348.16C1186.769455 134.981818 955.904 0 698.228364 0 440.366545 0 210.618182 134.981818 52.363636 348.16c-69.818182 94.021818-69.818182 233.658182 0 327.68C210.618182 889.018182 441.390545 1024 698.228364 1024c257.861818 0 487.796364-134.981818 645.957818-348.16 69.818182-94.021818 69.818182-233.658182 0-327.68zM698.414545 845.917091A324.794182 324.794182 0 0 1 374.085818 521.309091a324.887273 324.887273 0 0 1 324.328727-324.514909 324.887273 324.887273 0 0 1 324.421819 324.514909 324.794182 324.794182 0 0 1-324.421819 324.514909z m0-549.236364a224.721455 224.721455 0 0 0 0 449.349818 224.628364 224.628364 0 0 0 0-449.256727z"/></symbol>
    <symbol id="icon-setting" viewBox="0 0 1024 1024"><path d="M904.533333 422.4l-85.333333-14.933333-17.066667-38.4 49.066667-70.4c14.933333-21.333333 12.8-49.066667-6.4-68.266667l-53.333333-53.333333c-19.2-19.2-46.933333-21.333333-68.266667-6.4l-70.4 49.066666-38.4-17.066666-14.933333-85.333334c-2.133333-23.466667-23.466667-42.666667-49.066667-42.666666h-74.666667c-25.6 0-46.933333 19.2-53.333333 44.8l-14.933333 85.333333-38.4 17.066667L296.533333 170.666667c-21.333333-14.933333-49.066667-12.8-68.266666 6.4l-53.333334 53.333333c-19.2 19.2-21.333333 46.933333-6.4 68.266667l49.066667 70.4-17.066667 38.4-85.333333 14.933333c-21.333333 4.266667-40.533333 25.6-40.533333 51.2v74.666667c0 25.6 19.2 46.933333 44.8 53.333333l85.333333 14.933333 17.066667 38.4L170.666667 727.466667c-14.933333 21.333333-12.8 49.066667 6.4 68.266666l53.333333 53.333334c19.2 19.2 46.933333 21.333333 68.266667 6.4l70.4-49.066667 38.4 17.066667 14.933333 85.333333c4.266667 25.6 25.6 44.8 53.333333 44.8h74.666667c25.6 0 46.933333-19.2 53.333333-44.8l14.933334-85.333333 38.4-17.066667 70.4 49.066667c21.333333 14.933333 49.066667 12.8 68.266666-6.4l53.333334-53.333334c19.2-19.2 21.333333-46.933333 6.4-68.266666l-49.066667-70.4 17.066667-38.4 85.333333-14.933334c25.6-4.266667 44.8-25.6 44.8-53.333333v-74.666667c-4.266667-27.733333-23.466667-49.066667-49.066667-53.333333z m-19.2 117.333333l-93.866666 17.066667c-10.666667 2.133333-19.2 8.533333-23.466667 19.2l-29.866667 70.4c-4.266667 10.666667-2.133333 21.333333 4.266667 29.866667l53.333333 76.8-40.533333 40.533333-76.8-53.333333c-8.533333-6.4-21.333333-8.533333-29.866667-4.266667L576 768c-10.666667 4.266667-17.066667 12.8-19.2 23.466667l-17.066667 93.866666h-57.6l-17.066666-93.866666c-2.133333-10.666667-8.533333-19.2-19.2-23.466667l-70.4-29.866667c-10.666667-4.266667-21.333333-2.133333-29.866667 4.266667l-76.8 53.333333-40.533333-40.533333 53.333333-76.8c6.4-8.533333 8.533333-21.333333 4.266667-29.866667L256 576c-4.266667-10.666667-12.8-17.066667-23.466667-19.2l-93.866666-17.066667v-57.6l93.866666-17.066666c10.666667-2.133333 19.2-8.533333 23.466667-19.2l29.866667-70.4c4.266667-10.666667 2.133333-21.333333-4.266667-29.866667l-53.333333-76.8 40.533333-40.533333 76.8 53.333333c8.533333 6.4 21.333333 8.533333 29.866667 4.266667L448 256c10.666667-4.266667 17.066667-12.8 19.2-23.466667l17.066667-93.866666h57.6l17.066666 93.866666c2.133333 10.666667 8.533333 19.2 19.2 23.466667l70.4 29.866667c10.666667 4.266667 21.333333 2.133333 29.866667-4.266667l76.8-53.333333 40.533333 40.533333-53.333333 76.8c-6.4 8.533333-8.533333 21.333333-4.266667 29.866667L768 448c4.266667 10.666667 12.8 17.066667 23.466667 19.2l93.866666 17.066667v55.466666z" fill="#666666" ></path><path d="M512 394.666667c-64 0-117.333333 53.333333-117.333333 117.333333s53.333333 117.333333 117.333333 117.333333 117.333333-53.333333 117.333333-117.333333-53.333333-117.333333-117.333333-117.333333z m0 170.666666c-29.866667 0-53.333333-23.466667-53.333333-53.333333s23.466667-53.333333 53.333333-53.333333 53.333333 23.466667 53.333333 53.333333-23.466667 53.333333-53.333333 53.333333z" fill="#666666" ></path></symbol>
</svg>`,(h=>{var c=(l=(l=document.getElementsByTagName("script"))[l.length-1]).getAttribute("data-injectcss"),l=l.getAttribute("data-disable-injectsvg");if(!l){var t,v,a,e,i,o=function(c,l){l.parentNode.insertBefore(c,l)};if(c&&!h.__iconfont__svg__cssinject__){h.__iconfont__svg__cssinject__=!0;try{document.write("<style>.svgfont {display: inline-block;width: 1em;height: 1em;fill: currentColor;vertical-align: -0.1em;font-size:16px;}</style>")}catch(c){console&&console.log(c)}}t=function(){var c,l=document.createElement("div");l.innerHTML=h._iconfont_svg_string_,(l=l.getElementsByTagName("svg")[0])&&(l.setAttribute("aria-hidden","true"),l.style.position="absolute",l.style.width=0,l.style.height=0,l.style.overflow="hidden",l=l,(c=document.body).firstChild?o(l,c.firstChild):c.appendChild(l))},document.addEventListener?~["complete","loaded","interactive"].indexOf(document.readyState)?setTimeout(t,0):(v=function(){document.removeEventListener("DOMContentLoaded",v,!1),t()},document.addEventListener("DOMContentLoaded",v,!1)):document.attachEvent&&(a=t,e=h.document,i=!1,n(),e.onreadystatechange=function(){"complete"==e.readyState&&(e.onreadystatechange=null,m())})}function m(){i||(i=!0,a())}function n(){try{e.documentElement.doScroll("left")}catch(c){return void setTimeout(n,50)}m()}})(window);


