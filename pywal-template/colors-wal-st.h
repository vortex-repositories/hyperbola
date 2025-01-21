const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#071115", /* black   */
  [1] = "#273D42", /* red     */
  [2] = "#344A4D", /* green   */
  [3] = "#44595A", /* yellow  */
  [4] = "#4C5F5F", /* blue    */
  [5] = "#546868", /* magenta */
  [6] = "#637876", /* cyan    */
  [7] = "#bfad99", /* white   */

  /* 8 bright colors */
  [8]  = "#85796b",  /* black   */
  [9]  = "#273D42",  /* red     */
  [10] = "#344A4D", /* green   */
  [11] = "#44595A", /* yellow  */
  [12] = "#4C5F5F", /* blue    */
  [13] = "#546868", /* magenta */
  [14] = "#637876", /* cyan    */
  [15] = "#bfad99", /* white   */

  /* special colors */
  [256] = "#071115", /* background */
  [257] = "#bfad99", /* foreground */
  [258] = "#bfad99",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
