--招来の対価
--Trial and Tribulation
function c26285788.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc26285788(c26285788,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c26285788,EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c26285788.target)
	e1:SetOperation(c26285788.activate)
	c:RegisterEffect(e1)
	--Keep track of how many monsters have been Tributed each turn
	aux.GlobalCheck(s,function()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_RELEASE)
		ge1:SetOperation(c26285788.addcount)
		Duel.RegisterEffect(ge1,0)
	end)
end
function c26285788.addcount(e,tp,eg,ep,ev,re,r,rp)
	local p=nil
	for tc in eg:Iter() do
		p=tc:GetReasonPlayer()
		if tc:IsMonster() and not tc:IsType(TYPE_TOKEN) and (tc:IsPreviousLocation(LOCATION_MZONE)
			or (tc:IsPreviousLocation(LOCATION_HAND) and tc:IsPreviousControler(p))) then
			Duel.RegisterFlagEffect(p,c26285788,RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c26285788.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
	Duel.SetPossibleOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetPossibleOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_GRAVE)
	Duel.SetPossibleOperationInfo(0,CATEGORY_DESTROY,nil,1,PLAYER_ALL,LOCATION_ONFIELD)
end
function c26285788.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(function(_,tp) return Duel.GetFlagEffect(tp,c26285788)>0 end)
	e1:SetOperation(c26285788.effectop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c26285788.thfilter(c)
	return c:IsMonster() and c:IsAbleToHand()
end
function c26285788.effectop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,c26285788)
	local ct=Duel.GetFlagEffect(tp,c26285788)
	if ct==1 then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif ct==2 then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c26285788.thfilter),tp,LOCATION_GRAVE,0,nil)
		if #g>=2 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local tg=g:Select(tp,2,2,nil)
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tg)
		end
	else
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if #g>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local tg=g:Select(tp,1,3,nil)
			if #tg==0 then return end
			Duel.HintSelection(tg,true)
			Duel.Destroy(tg,REASON_EFFECT)
		end
	end
end