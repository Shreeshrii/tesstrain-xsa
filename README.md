# tesstrain-xsa

Finetune Training and OCR evaluation of Tesseract 5.0.0 Alpha for Sabaean language in Ancient South Arabian script using
 [tesstrain Training workflow for Tesseract 4 as a Makefile](https://github.com/tesseract-ocr/tesstrain). Certain file locations and scripts have been modified compared to source repos.

OCR evaluation is done using [ISRI Analytic Tools for OCR Evaluation with UTF-8 support](https://github.com/eddieantonio/ocreval) and  and [The ocrevalUAtion tool](https://sites.google.com/site/textdigitisation/ocrevaluation).

## xsa - Sabaean language in Ancient South Arabian script

Replace the top layer training is being done using [2 fonts](langdata/xsa.fontslist.txt). The sample [training text](langdata/xsa.txt) is scraped from google search.

## Training Steps

* Update [training text](langdata/xsa.txt)
* List [available fonts that can render the training text](langdata/xsa.fontslist.txt)
* Update fonts directory unicodefontdir in [txt2lstmf.sh](txt2lstmf.sh)
* Run [txt2lstmf.sh](txt2lstmf.sh) to create the images, ground truth and lstmf files in [gt/xsa](gt/xsa)
* Run [trainlayer.sh](trainlayer.sh) to download the starting ara.traineddata and other files and start the training via makefile
* Run [checkpointeval.sh](checkpointeval.sh) to evaluate the accuracy of different checkpoints.

## Evaluation Results

See [reports](reports/checkpointeval.txt). 

Currently best accuracy for both fonts seems to be the following:

------------------------------------------------------------------- Arabic  xsa-xsaLayer_0.869_2978_7700
------------------------------------------------------------------- Arabic xsa-Quivira-xsaLayer_0.869_2978_7700
   83.30%  Accuracy
------------------------------------------------------------------- Arabic xsa-Segoe_UI_Historic-xsaLayer_0.869_2978_7700
   81.60%  Accuracy

