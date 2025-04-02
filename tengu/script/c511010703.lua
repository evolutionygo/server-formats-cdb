--インフェルニティ・ビートル (Anime)
--Infernity Beetle (Anime)
--added by ClaireStanfield
local s,c511010703,alias=GetID()
function c511010703.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511010703(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010703.condition)
	e1:SetCost(c511010703.cost)
	e1:SetTarget(c511010703.target)
	e1:SetOperation(c511010703.operation)
	c:RegisterEffect(e1)
end
function c511010703.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c511010703.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511010703.filter(c,e,tp)
	return c:IsCode(alias) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511010703.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if e:GetHandler():GetSequence()<5 then ft=ft+1 end
	if chk==0 then return ft>1 and Duel.IsExistingMatchingCard(c511010703.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,2,nil,e,tp)
		and not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c511010703.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511010703.filter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,2,2,nil,e,tp)
	if #g==2 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end