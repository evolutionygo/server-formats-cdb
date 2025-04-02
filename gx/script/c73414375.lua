--ディメンション・ポッド
--Dimension Jar
function c73414375.initial_effect(c)
	--Banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc73414375(c73414375,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c73414375.target)
	e1:SetOperation(c73414375.operation)
	c:RegisterEffect(e1)
end
function c73414375.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetPossibleOperationInfo(0,CATEGORY_REMOVE,nil,3,PLAYER_ALL,LOCATION_GRAVE)
end
function c73414375.rmfilter(c,tp)
	return c:IsAbleToRemove(tp) and aux.SpElimFilter(c)
end
function c73414375.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local p=Duel.GetTurnPlayer()
	if Duel.IsExistingTarget(c73414375.rmfilter,p,0,LOCATION_MZONE+LOCATION_GRAVE,1,nil,1-p) and Duel.SelectYesNo(p,aux.Stringc73414375(c73414375,1)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(p,c73414375.rmfilter,p,0,LOCATION_MZONE+LOCATION_GRAVE,1,3,nil,p)
		Duel.HintSelection(rg,true)
		g:Merge(rg)
	end
	if Duel.IsExistingTarget(c73414375.rmfilter,1-p,0,LOCATION_MZONE+LOCATION_GRAVE,1,nil,1-p) and Duel.SelectYesNo(1-p,aux.Stringc73414375(c73414375,1)) then
		Duel.Hint(HINT_SELECTMSG,1-p,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(1-p,c73414375.rmfilter,1-p,0,LOCATION_MZONE+LOCATION_GRAVE,1,3,nil,1-p)
		Duel.HintSelection(rg,true)
		g:Merge(rg)
	end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end