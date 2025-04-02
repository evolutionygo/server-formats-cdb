--パワー・ツール・ドラゴン (Anime)
--Power Tool Dragon (Anime)
--Scripted by Larry126
function c511600116.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--Search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600116(c511600116,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511600116.thtg)
	e1:SetOperation(c511600116.thop)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetTarget(c511600116.desreptg)
	e2:SetOperation(c511600116.desrepop)
	c:RegisterEffect(e2)
end
function c511600116.thfilter(c)
	return c:IsEquipSpell() and c:IsAbleToHand()
end
function c511600116.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600116.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c511600116.thop(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetMatchingGroup(c511600116.thfilter,tp,LOCATION_DECK,0,nil)
	local g=cg:RandomSelect(tp,1)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c511600116.repfilter(c)
	return c:IsFaceup() and c:IsEquipSpell() and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
end
function c511600116.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE)
		and c:GetEquipGroup():IsExists(c511600116.repfilter,1,nil) end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c511600116.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetEquipGroup()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:FilterSelect(tp,c511600116.repfilter,1,1,nil)
	Duel.SendtoGrave(tg,REASON_EFFECT)
end