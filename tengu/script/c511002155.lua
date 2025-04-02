--ダーク・アリゲーター (Manga)
--Dark Alligator (Manga)
function c511002155.initial_effect(c)
	--You can Tribute 4 monsters to Tribute Summon this card
	aux.AddNormalSummonProcedure(c,true,true,4,4,SUMMON_TYPE_TRIBUTE+1,aux.Stringc511002155(c511002155,0))
	--Special Summon 2 "Alligator Tokens"
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002155(c511002155,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(function(e) return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE+1) end)
	e1:SetTarget(c511002155.sptg)
	e1:SetOperation(c511002155.spop)
	c:RegisterEffect(e1)
end
c511002155.listed_names={34479659}
function c511002155.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,0)
end
function c511002155.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,34479659,0,TYPES_TOKEN,2000,0,1,RACE_REPTILE,ATTRIBUTE_DARK) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,34479659)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end