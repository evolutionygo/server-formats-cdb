--ＴＧ サイバー・マジシャン (TF5)
--T.G. Cyber Magician (TF5)
--fixed by ClaireStanfield
function c511000072.initial_effect(c)
	--synchro limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c511000072.synlimit)
	c:RegisterEffect(e1)
	--synchro custom
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetOperation(c511000072.synop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_HAND_SYNCHRO)
	e3:SetLabel(c511000072)
	e3:SetValue(c511000072.synval)
	c:RegisterEffect(e3)
	--Type Machine
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_ADD_RACE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(RACE_MACHINE)
	c:RegisterEffect(e4)
	--Search 1 "T.G. Cyber Magician"
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc511000072(c511000072,0))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c511000072.scon)
	e5:SetTarget(c511000072.stg)
	e5:SetOperation(c511000072.sop)
	c:RegisterEffect(e5)
end
c511000072.listed_series={SET_TG}
c511000072.listed_names={64910482} --T.G. Cyber Magician
function c511000072.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(SET_TG)
end
function c511000072.synval(e,c,sc)
	if c:IsLocation(LOCATION_HAND) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_HAND_SYNCHRO+EFFECT_SYNCHRO_CHECK)
		e1:SetLabel(c511000072)
		e1:SetTarget(c511000072.synchktg)
		c:RegisterEffect(e1)
		return true
	else return false end
end
function c511000072.chk2(c)
	if not c:IsHasEffect(EFFECT_HAND_SYNCHRO) or c:IsHasEffect(EFFECT_HAND_SYNCHRO+EFFECT_SYNCHRO_CHECK) then return false end
	local te={c:GetCardEffect(EFFECT_HAND_SYNCHRO)}
	for i=1,#te do
		local e=te[i]
		if e:GetLabel()==c511000072 then return true end
	end
	return false
end
function c511000072.synchktg(e,c,sg,tg,ntg,tsg,ntsg)
	if c then
		local res=true
		if #sg>=2 or (not tg:IsExists(c511000072.chk2,1,c) and not ntg:IsExists(c511000072.chk2,1,c) 
			and not sg:IsExists(c511000072.chk2,1,c)) then return false end
		local ttg=tg:Filter(c511000072.chk2,nil)
		local nttg=ntg:Filter(c511000072.chk2,nil)
		local trg=tg:Clone()
		local ntrg=ntg:Clone()
		trg:Sub(ttg)
		ntrg:Sub(nttg)
		return res,trg,ntrg
	else
		return #sg<2
	end
end
function c511000072.synop(e,tg,ntg,sg,lv,sc,tp)
	return #sg==2,false
end
function c511000072.scon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c511000072.sfilter(c)
	return c:IsCode(64910482) and c:IsAbleToHand()
end
function c511000072.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000072.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000072.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000072.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end