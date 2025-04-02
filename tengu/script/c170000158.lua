--呪符竜 (Anime)
--Amulet Dragon (anime)
function c170000158.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Summon procedure
	aux.AddFusionProcCode2(c,true,true,1784686,CARD_DARK_MAGICIAN)
	--Gain 300 ATK per Spell Card banished
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCost(c170000158.cost)
	e1:SetTarget(c170000158.target)
	e1:SetOperation(c170000158.operation)
	c:RegisterEffect(e1)
end
c170000158.listed_names={1784686,CARD_DARK_MAGICIAN}
c170000158.material_setcode=SET_DARK_MAGICIAN
function c170000158.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsSpell,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return #g>0 and g:FilterCount(Card.IsAbleToRemoveAsCost,nil)==#g end
	e:SetLabel(#g)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c170000158.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,e:GetHandler(),1,tp,e:GetLabel()*300)
end
function c170000158.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*300)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
end