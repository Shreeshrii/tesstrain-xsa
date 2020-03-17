# tesstrain-xsa

Finetune Training and OCR evaluation of Tesseract 5.0.0 Alpha for Sabaean language in Ancient South Arabian script using
 [tesstrain Training workflow for Tesseract 4 as a Makefile](https://github.com/tesseract-ocr/tesstrain). Certain file locations and scripts have been modified compared to source repos.

OCR evaluation is done using [ISRI Analytic Tools for OCR Evaluation with UTF-8 support](https://github.com/eddieantonio/ocreval) and  and [The ocrevalUAtion tool](https://sites.google.com/site/textdigitisation/ocrevaluation).

## [best_xsa1 - Sabaean language in Ancient South Arabian script - Version 1](https://github.com/Shreeshrii/tesstrain-xsa/releases/tag/best_xsa1)

Replace the top layer training was done using two fonts. The sample training text was scraped via google search.

### Training Steps (links to files as of Version 1)

* Make [training text](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/langdata/xsa.txt)
* List [available fonts that can render the training text](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/langdata/xsa.fontslist.txt)
* Update fonts directory unicodefontdir in [txt2lstmf.sh](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/txt2lstmf.sh)
* Run [txt2lstmf.sh](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/txt2lstmf.sh) to create the images, ground truth and lstmf files in [gt/xsa](https://github.com/Shreeshrii/tesstrain-xsa/tree/best_xsa1/gt/xsa)
* Run [trainlayer.sh](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/trainlayer.sh) to download the starting ara.traineddata and other files and start the training via makefile
* Run [checkpointeval.sh](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/checkpointeval.sh) to evaluate the accuracy of different checkpoints.
* Resulting traineddata file, which can be used as starting model for further training, is at [best_xsa1. traineddata](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1. traineddata).

### Evaluation Results

Quivira -    83.30%  Accuracy

Segoe_UI_Historic -    81.60%  Accuracy

See [reports](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa1/reports/checkpointeval.txt) for more details. 

## best_xsa2 - Sabaean language in Ancient South Arabian script - Version 2

Replace the top layer training was done using four Unicode fonts. The training text was scraped via google search. A small subset was created by copying Latin transcription text from [CSAI Inscriptions](http://dasi.cnr.it/index.php?id=79&prjId=1&corId=5&colId=0&navId=522207406&recId=2149) and converting to Unicode via [a sed script](latin2unicode.sh). 

Qataban, one of the fonts used, was [rendering space as a square box with 00 20](langdata/nospace.Qataban.png) in it. So, line images for it were created with a wordlist type of [training text with no spaces](langdata/nospace.training_text) in it. [Training text with spaces](langdata/xsa.training_text) was used for the [other three fonts](langdata/xsa.fontslist.txt).

![nospace.Qataban.png](https://github.com/Shreeshrii/tesstrain-xsa/blob/best_xsa2/langdata/nospace.Qataban.png?raw=true "Qataban font does not render space correctly")


